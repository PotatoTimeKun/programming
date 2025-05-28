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
        unsigned int legnth = 0;
        for(int i=0;i<chunkList->len()){
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
        for(int i=0;i<chunkList->len()){
            char* typeName = (*chunkList)(i).type();
            if(!strEqual(typeName,dataChunkName)){
                delete typeName;
                continue;
            }
            delete typeName;
            Chunk chunk = (*chunkList)(i)
            unsigned char* chunkDataPtr = chunk.readData();
            for(int j=0;j<chunk.len();j++){
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

class ZlibDecoder{ 
    // ヘッダーは無視、DEFLATEデータのみ読む
    ZlibDecoder(unsigned char* zlibData, unsigned int imgWidth, unsigned int imgHeight, unsigned int bitDepth,unsigned int isRGBA) :
     data(zlibData + 2),width(imgWidth),height(imgHeight),isFullColor(bitDepth==8),haveAlpha(isRGBA) {}
    unsigned char* decode(){
        decoderInit();
        decoded = new unsigned char[(width+1)*height*(isFullColor?1:2)*(haveAlpha?4:3)]; // フィルタ付き画像データの分だけ確保
        bool BFINAL = false;
        while (!BFINAL){ // DEFLATEブロックごとにループ
            BFINAL = nextBit();
            unsigned char BTYPE = (nextBit()?1:0)*2 + (nextBit()?1:0);
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
    void readAsNonpress(){}
    void readAsFixedHuffman(){}
    void readAsDynamicHuffman(){}
    unsigned char* docoderInit(){
        ptr = data;
        bitCount = 0;
    }
    bool nextBit(){
        if(bitCount>=8){
            bitCount = 0;
            ptr++;
        }
        bool answer = ((*ptr) & (1<<bitCount) == 0) ? false : true;
        bitCount++;
        return answer;
    }
    void padding(){
        if(bitCount==0) return;
        bitCount = 0;
        ptr++;
    }
    unsigned char* data;
    unsigned char* decoded;
    unsigned int width;
    unsigned int height;
    bool isFullColor;
    bool haveAlpha;
    unsigned char* ptr;
    unsigned char bitCount;
}

class Pixel{ // カラータイプはRGBもしくはRGBA , 深度は1バイトまたは2バイト
    public:
    Pixel(unsigned char* head,unsigned char depth,bool isRGBA) : data(head),bitDepth(depth),haveAlpha(isRGBA) {}
    unsigned int R(){
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(data);
        }
        else {
            answer = (static_cast<unsigned int>(data)) << 8;
            answer += static_cast<unsigned int>(data + 1);
        }
        return answer;
    }
    unsigned int G(){
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(data + 1);
        }
        else {
            answer = (static_cast<unsigned int>(data + 2)) << 8;
            answer += static_cast<unsigned int>(data + 2 + 1);
        }
        return answer;
    }
    unsigned int B(){
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(data + 2);
        }
        else {
            answer = (static_cast<unsigned int>(data + 4)) << 8;
            answer += static_cast<unsigned int>(data + 4 + 1);
        }
        return answer;
    }
    unsigned int A(){
        if (!haveAlpha) {
            return (bitDepth==8 ? 0xff : 0xffff);
        }
        unsigned int answer = 0;
        if (bitDepth == 8) {
            answer = static_cast<unsigned int>(data + 3);
        }
        else {
            answer = (static_cast<unsigned int>(data + 6)) << 8;
            answer += static_cast<unsigned int>(data + 6 + 1);
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
    PngDecoder decoder("test.png");
}