#include <fstream>
#include <iostream>
#include <stdexcept>
using namespace std;

template <class SomeClass> class List{
    public:
    List() : data(nullptr), next(nullptr) {}
    ~List(){
        delete data;
        delete next;
    }
    SomeClass& operator()(int index){
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
    Chunk(char* binary){}
    ~Chunk(){}
    private:
    unsigned int length;
    char chunkType[5];
    unsigned char* data;
};

class PngData {
    public:
    PngData(unsigned char* binary) : binaryData(binary){
        for(int i=0;i<8;i++){ // 一応シグネチャを確認
            if (binary[i]!=SIGNATURE[i]) {
                throw runtime_error("PNGデコーダ:これはPNGファイルではありません");
            }
        }
        chunkList = new List<Chunk>();
    }
    ~PngData() {
        delete[] binaryData;
    }
    private:
    unsigned char* binaryData; // ファイルデータ
    List<Chunk>* chunkList;
    static const unsigned char SIGNATURE[8]; // PNGシグネチャ
};
const unsigned char PngData::SIGNATURE[8] = {0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A}; 

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
