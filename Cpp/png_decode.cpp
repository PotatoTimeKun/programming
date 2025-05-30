#include <fstream>
#include <iostream>
#include <stdexcept>
using namespace std;

unsigned int UCharToUInt(unsigned char* ucharData){ // ビッグエンディアンでunsigned intに解釈
    unsigned int answer = 0;
    for(int i=0;i<4;i++){
        answer = (answer << 8) + static_cast<unsigned int>(ucharData[i]);
    }
    return answer;
}


bool strEqual(char* a,char* b){ // a == b
    if (a[0]!=b[0]) {
        return false;
    }
    for(int i=0;a[i]!='\0' and b[i]!='\0';i++){
        if (a[i+1]!=b[i+1]){
            return false;
        }
    }
    return true;
}

template <class SomeClass> class List{
    public:
    List() : data(nullptr), next(nullptr) {}
    ~List(){
        delete data;
        delete next;
    }
    SomeClass& operator()(int index){ // インスタンス(インデックス)で使える
        if (index<0) {
            throw runtime_error("List: 負のインデックスは使えません");
        }
        if (data==0) {
            throw runtime_error("List: out of index");
        }
        if (next==0 && index>0) {
            throw runtime_error("List: out of index");
        }
        if (next==0) {
            return *data;
        }
        if (index==0) {
            return *data;
        }
        return (*next)(index-1);
    }
    int len(){
        if (data==0) return 0;
        if (next==0) return 1;
        return next->len()+1;
    }
    void add(SomeClass *newData){
        if (data==0) {
            data=newData;
            return;
        }
        if (next==0) {
            next = new List<SomeClass>();
            next->add(newData);
            return;
        }
        next->add(newData);
    }
    private:
    SomeClass* data;
    List* next;
};

class Chunk{
    public:
    Chunk(unsigned char** head){
        length = UCharToUInt(*head);
        *head += 4; // Length分加算
        for(int i=0;i<4;i++){
            chunkType[i]=(*head)[i];
        }
        chunkType[4] = '\0';
        *head += 4; // ChunkType分加算
        data = *head;
        *head += length; // ChunkData分加算
        *head += 4; // CRC分加算
    }
    ~Chunk(){}

    char* type(){ // チャンクタイプを返す、newを使ってるからdeleteが必要
        char* name = new char[5];
        for(int i=0;i<5;i++){
            name[i] = chunkType[i];
        }
        return name;
    }
    unsigned char* readData(){
        return data;
    }
    unsigned int getLength(){
        return length;
    }
    private:
    unsigned int length;
    char chunkType[5];
    unsigned char* data;
    unsigned char* nextChunk;
};

class PngData {
    public:
    PngData(unsigned char* binary) : binaryData(binary){
        for(int i=0;i<8;i++){ // 一応シグネチャを確認
            if (binary[i]!=SIGNATURE[i]) {
                throw runtime_error("PNGデコーダ:これはPNGファイルではありません");
            }
        }
        
        // チャンクをすべて読んでリストに入れる
        chunkList = new List<Chunk>();
        char endChunkName[5] = "IEND";
        binary += 8; // シグネチャ分加算
        while(true){ 
            Chunk* newChunk = new Chunk(&binary);
            chunkList->add(newChunk);
            char* name = newChunk->type();
            cout << name << " Chunk" << endl;
            if (strEqual(name,endChunkName)) {
                delete name;
                break;
            }
            delete name;
        }

        // ヘッダーを読む
        char headerChunkName[5] = "IHDR";
        for(int i=0;i<chunkList->len();i++){
            char* name = (*chunkList)(i).type();
            if (!strEqual(name,headerChunkName)) {
                delete name;
                continue;
            }
            delete name;
            readIHDRChunk(&(*chunkList)(i));
            break;
        }
        cout << "width:" << width << endl;
        cout << "height:" << height << endl;
        cout << "bit depth:" << bitDepth << endl;
        cout << "color type:" << colorTypeToName() << endl;
    }
    ~PngData() {
        delete[] binaryData;
        delete chunkList;
    }
    unsigned int getWidth(){
        return width;
    }
    unsigned int getHeight(){
        return height;
    }
    unsigned int getBitDepth(){
        return bitDepth;
    }
    const char* getColorType(){
        return colorTypeToName();
    }
    unsigned char* getZlibData(){ // newを使うのでdeleteが必要
        // 合計のサイズを取得
        char dataChunkName[5] = "IDAT";
        unsigned int length = 0;
        for(int i=0;i<chunkList->len();i++){
            char* typeName = (*chunkList)(i).type();
            if(!strEqual(typeName,dataChunkName)){
                delete typeName;
                continue;
            }
            delete typeName;
            length += (*chunkList)(i).getLength();
        }

        // 内容をコピー
        unsigned char* zlibData = new unsigned char[length];
        unsigned char* ptr = zlibData;
        for(int i=0;i<chunkList->len();i++){
            char* typeName = (*chunkList)(i).type();
            if(!strEqual(typeName,dataChunkName)){
                delete typeName;
                continue;
            }
            delete typeName;
            Chunk chunk = (*chunkList)(i);
            unsigned char* chunkDataPtr = chunk.readData();
            for(int j=0;j<chunk.getLength();j++){
                *ptr = *chunkDataPtr;
                ptr++;
                chunkDataPtr++;
            }
        }

        return zlibData;
    }
    private:
    void readIHDRChunk(Chunk* ihdr){
        unsigned char* data = ihdr->readData();
        width = UCharToUInt(data);
        data += 4;
        height = UCharToUInt(data);
        data += 4;
        bitDepth = static_cast<unsigned int>(*data);
        data ++;
        colorType = *data;
    }
    const char* colorTypeToName(){
        if (colorType == 2)
            return "RGB";
        if (colorType == 6)
            return "RGBA";
        return "UNKNOWN";
    }
    unsigned char* binaryData; // ファイルデータ
    List<Chunk>* chunkList;
    static const unsigned char SIGNATURE[8]; // PNGシグネチャ
    unsigned int width;
    unsigned int height;
    unsigned int bitDepth;
    unsigned char colorType;
};
const unsigned char PngData::SIGNATURE[8] = {0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A}; 

template <class SomeClass> class Tree{
    public:
    Tree(SomeClass newValue) : right(nullptr),left(nullptr),value(newValue) {}
    ~Tree() {
        delete right;
        delete left;
    }
    SomeClass getValue(){
        return value;
    }
    bool isLeaf(){
        return (right==nullptr && left==nullptr);
    }
    Tree* getRight(){
        return right;
    }
    void setRight(SomeClass newValue){
        Tree* rightTree = new Tree(newValue);
        right = rightTree;
    }
    Tree* getLeft(){
        return left;
    }
    void setLeft(SomeClass newValue){
        Tree* leftTree = new Tree(newValue);
        left = leftTree;
    }
    private:
    SomeClass value;
    Tree* right;
    Tree* left;
};

class ZlibDecoder{ 
    public:
    // ヘッダーは無視、DEFLATEデータのみ読む
    ZlibDecoder(unsigned char* zlibData, unsigned int imgWidth, unsigned int imgHeight, unsigned int bitDepth,unsigned int isRGBA) :
     data(zlibData + 2),width(imgWidth),height(imgHeight),isFullColor(bitDepth==8),haveAlpha(isRGBA),fixedHuffmanTree(nullptr) {}
    unsigned char* decode(){
        decoderInit();
        decoded = new unsigned char[(width+1)*height*(isFullColor?1:2)*(haveAlpha?4:3)]; // フィルタ付き画像データの分だけ確保
        decodedHeader = decoded;
        bool BFINAL = false;
        while (!BFINAL){ // DEFLATEブロックごとにループ
            BFINAL = nextBit();
            unsigned char BTYPE = (nextBit()?1:0) + ((nextBit()?1:0)<<1);
            if (BTYPE==0) { // 非圧縮ブロック
                readAsNonpress();
            }
            if (BTYPE==1) { // 固定ハフマンブロック
                readAsFixedHuffman();
            }
            if (BTYPE==2) { // 動的ハフマンブロック
                readAsDynamicHuffman();
            }
        }
        return decoded;
    }
    private:
    void readAsNonpress(){
        unsigned int length = ((*ptr) << 8) + *(ptr+1);
        ptr += 4; // LENとNLEN分加算
        bitCount = 0; // 一応
        for (int i=0;i<length;i++) {
            *decodedHeader = *ptr;
            ptr++;
            decodedHeader++;
        }
    }
    void readAsFixedHuffman(){
        Tree<unsigned short>* tree = getFixedHuffmanTree();

        Tree<unsigned short>* head = tree;
        while(true){
            // コードで木をたどる
            bool bit = nextBit();
            if (bit==false) {
                head = head->getLeft();
            }
            else {
                head = head->getRight();
            }
            unsigned short value = head->getValue();
            if (!head->isLeaf()) continue; // 葉でないならまた戻ってたどる

            if (value == 256) break; // end-of-block

            head = tree;
            if (value<255) { // リテラルコード
                *decodedHeader = static_cast<unsigned char>(value);
                decodedHeader++;
                continue;
            }

            // 長さコード
            unsigned int length = readLengthCode(value);

            // 距離コード
            unsigned short distanceCode = 0;
            for(int i=0;i<5;i++){
                if (nextBit()) distanceCode += (1 << (4-i));
            }
            unsigned int distance = readDistanceCode(distanceCode);

            // データの繰り返しを行う
            for(unsigned int i=0;i<length;i++){
                *decodedHeader = *(decodedHeader-distance);
                decodedHeader++;
            }
        }
        padding();
    }
    void readAsDynamicHuffman(){}
    void decoderInit(){
        ptr = data;
        bitCount = 0;
    }
    bool nextBit(){
        if(bitCount>=8){
            bitCount = 0;
            ptr++;
        }
        bool answer = (((*ptr) & (1<<bitCount)) == 0) ? false : true;
        bitCount++;
        return answer;
    }
    void padding(){
        if(bitCount==0) return;
        bitCount = 0;
        ptr++;
    }
    Tree<unsigned short>* getFixedHuffmanTree(){
        if (fixedHuffmanTree!=nullptr) return fixedHuffmanTree;

        fixedHuffmanTree = new Tree<unsigned short>(INVALID);

        // 0-143 8ビット
        unsigned int base = 0x30; // ハフマンコード
        for(int i=0;i<=143;i++){
            Tree<unsigned short>* head = fixedHuffmanTree;
            for(int j=0;j<7;j++){
                if ((base&(1<<(7-j))) == 0){ // 0は左
                    if (head->getLeft()==nullptr) head->setLeft(INVALID);
                    head = head->getLeft();
                }
                else if ((base&(1<<(7-j))) != 0){ // 1は右
                    if (head->getRight()==nullptr) head->setRight(INVALID);
                    head = head->getRight();
                }
            }
            if ((base&1) == 0) {
                head->setLeft(static_cast<unsigned short>(i));
            }
            else {
                head->setRight(static_cast<unsigned short>(i));
            }
            base++;
        }

        // 144-255 9ビット
        base = 0x190;
        for(int i=144;i<=255;i++){
            Tree<unsigned short>* head = fixedHuffmanTree;
            for(int j=0;j<8;j++){
                if ((base&(1<<(8-j))) == 0){
                    if (head->getLeft()==nullptr) head->setLeft(INVALID);
                    head = head->getLeft();
                }
                else if ((base&(1<<(8-j))) != 0){
                    if (head->getRight()==nullptr) head->setRight(INVALID);
                    head = head->getRight();
                }
            }
            if ((base&1) == 0) {
                head->setLeft(static_cast<unsigned short>(i));
            }
            else {
                head->setRight(static_cast<unsigned short>(i));
            }
            base++;
        }

        // 256-279 7ビット
        base = 0x00;
        for(int i=256;i<=279;i++){
            Tree<unsigned short>* head = fixedHuffmanTree;
            for(int j=0;j<6;j++){
                if ((base&(1<<(6-j))) == 0){
                    if (head->getLeft()==nullptr) head->setLeft(INVALID);
                    head = head->getLeft();
                }
                else if ((base&(1<<(6-j))) != 0){
                    if (head->getRight()==nullptr) head->setRight(INVALID);
                    head = head->getRight();
                }
            }
            if ((base&1)==0) {
                head->setLeft(static_cast<unsigned short>(i));
            }
            else {
                head->setRight(static_cast<unsigned short>(i));
            }
            base++;
        }

        // 280-287 8ビット
        base = 0xC0;
        for(int i=280;i<=287;i++){
            Tree<unsigned short>* head = fixedHuffmanTree;
            for(int j=0;j<7;j++){
                if ((base&(1<<(7-j))) == 0){
                    if (head->getLeft()==nullptr) head->setLeft(INVALID);
                    head = head->getLeft();
                }
                else if ((base&(1<<(7-j))) != 0){
                    if (head->getRight()==nullptr) head->setRight(INVALID);
                    head = head->getRight();
                }
            }
            if ((base&1)==0) {
                head->setLeft(static_cast<unsigned short>(i));
            }
            else {
                head->setRight(static_cast<unsigned short>(i));
            }
            base++;
        }

        return fixedHuffmanTree;
    }
    unsigned int readLengthCode(unsigned short lengthCode) { // 長さコードから実際の長さを返す、追加ビットも見る
        if (lengthCode==285) return 258;
        if (lengthCode<=264) {
            return static_cast<unsigned int>(lengthCode-257+3);
        }
        unsigned int i = (lengthCode-265)/4;
        unsigned int j = (lengthCode-265)%4;
        unsigned int length = 3+(1<<(3+i)) + (1<<(i+1))*j;
        unsigned int extraBit = 0;
        for (unsigned int x=0;x<i+1;x++){
            extraBit = extraBit << 1;
            if (nextBit()) extraBit++;
        }
        return length + extraBit;
    }
    unsigned int readDistanceCode(unsigned short distanceCode) {
        if (distanceCode<=1) {
            return distanceCode + 1;
        }
        unsigned int i = (distanceCode-2)/2;
        unsigned int j = (distanceCode-2)%2;
        unsigned int distance = 1+(1<<(i+1)) + (1<<1)*j;
        unsigned int extraBit = 0;
        for (unsigned int x=0;x<i;x++){
            extraBit = extraBit << 1;
            if (nextBit()) extraBit++;
        }
        return distance + extraBit;
    }
    Tree<unsigned short>* fixedHuffmanTree;
    static const unsigned short INVALID;
    unsigned char* data;
    unsigned char* decoded;
    unsigned char* decodedHeader;
    unsigned int width;
    unsigned int height;
    bool isFullColor;
    bool haveAlpha;
    unsigned char* ptr;
    unsigned char bitCount;
};
const unsigned short ZlibDecoder::INVALID = 0xffff;

class Pixel{ // カラータイプはRGBもしくはRGBA , 深度は1バイトまたは2バイト
    public:
    Pixel(unsigned char* head,unsigned char depth,bool isRGBA) : data(head),bitDepth(depth),haveAlpha(isRGBA) {}
    unsigned int R(){
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(*data);
        }
        else {
            answer = static_cast<unsigned int>(*data) << 8;
            answer += static_cast<unsigned int>(*(data + 1));
        }
        return answer;
    }
    unsigned int G(){
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(*(data + 1));
        }
        else {
            answer = (static_cast<unsigned int>(*(data + 2))) << 8;
            answer += static_cast<unsigned int>(*(data + 2 + 1));
        }
        return answer;
    }
    unsigned int B(){
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(*(data + 2));
        }
        else {
            answer = (static_cast<unsigned int>(*(data + 4))) << 8;
            answer += static_cast<unsigned int>(*(data + 4 + 1));
        }
        return answer;
    }
    unsigned int A(){
        if (!haveAlpha) {
            return (bitDepth==8 ? 0xff : 0xffff);
        }
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(*(data + 3));
        }
        else {
            answer = (static_cast<unsigned int>(*(data + 6))) << 8;
            answer += static_cast<unsigned int>(*(data + 6 + 1));
        }
        return answer;
    }
    ~Pixel() {}
    private:
    unsigned char* data;
    unsigned char bitDepth;
    bool haveAlpha;
};

class Image{
    public:
    Image() : data(nullptr){}
    void readFromFilter(unsigned char* filter){}
    private:
    List<Pixel>* data;
    unsigned int width;
    unsigned int height;
};

class PngDecoder {
    public:
    PngDecoder (const char* filename) {
        // ファイル読み込み
        ifstream file(filename,ios::binary);
        file.seekg(0,ifstream::end);
        int fileSize = static_cast<int>(file.tellg());
        file.seekg(0,ifstream::beg);
        char* fileImage = new char[fileSize+1];
        file.read(fileImage,fileSize);
        data = new PngData(reinterpret_cast<unsigned char*>(fileImage));
    }
    ~PngDecoder () {
        delete data;
    }
    private:
    PngData *data;
};

int main(){
    // PngDecoder decoder("test.png");
    unsigned char data[] = {0x00,0x00,0xeb,0x67,0x64,0x04,0x22,0x00}; // 1 10 10111111 00110001 00110001 0000001 00010 0000000 00
    ZlibDecoder decoder(data,10,10,8,false);
    unsigned char* decoded = decoder.decode();
    for (int i=0;i<6;i++){
        cout << static_cast<unsigned int>(*(decoded+i)) << endl;
    }
}