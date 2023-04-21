#ifndef INCLUDE_CIPHER2
#define INCLUDE_CIPHER2
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
uint64_t lfsr=0;
void initRand(uint64_t seed){
    lfsr=seed;
}
uint64_t makeSeed(){
    return time(NULL)+(time(NULL)<<24)+(time(NULL)<<48);
}
uint64_t getRandBit(){
    uint64_t lsb=lfsr&1;
    lfsr>>=1;
    if(lsb)lfsr^=0xD800000000000000u;
    return lsb;
}
void ChaCha20_QR(uint32_t* a,uint32_t* b,uint32_t* c,uint32_t* d){
    *a+=*b; *d^=*a; *d=(*d<<16)|(*d>>(32-16));
    *c+=*d; *b^=*c; *b=(*b<<12)|(*b>>(32-12));
    *a+=*b; *d^=*a; *d=(*d<<8)|(*d>>(32-8));
    *c+=*d; *b^=*c; *b=(*b<<7)|(*b>>(32-7));
}
char* ChaCha20_PRF(char* key,char* nonce,uint32_t count){
    uint32_t table[4][4];
    table[0][0]=0xA914F587u;
    table[0][1]=0x90C074AFu;
    table[0][2]=0xB962785Cu;
    table[0][3]=0xD91ECC76u;
    table[3][0]=count;
    for(int i=0;i<2;i++){
        for(int j=0;j<4;j++){
            uint32_t block=0;
            for(int k=0;k<4;k++)block+=((uint32_t)key[i*4*4+j*4+k])<<(8*k);
            table[i+1][j]=block;
        }
    }
    for(int i=0;i<3;i++){
        uint32_t block=0;
        for(int j=0;j<4;j++)block+=((uint32_t)nonce[i*4+j])<<(8*j);
        table[3][i+1]=block;
    }
    uint32_t table_copy[4][4];
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++)table_copy[i][j]=table[i][j];
    }
    for(int i=0;i<10;i++){
        for(int j=0;j<4;j++)ChaCha20_QR(&(table[j][0]),&(table[j][1]),&(table[j][2]),&(table[j][3]));
        for(int j=0;j<4;j++)ChaCha20_QR(&(table[j][0]),&(table[(j+1)%4][1]),&(table[(j+2)%4][2]),&(table[(j+3)%4][3]));
    }
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++)table[i][j]+=table_copy[i][j];
    }
    char* char_table=(char*)malloc(sizeof(char)*4*4*4);
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            for(int k=0;k<4;k++)char_table[i*4*4+j*4+k]=(char)(table[i][j]>>(k*8));
        }
    }
    return char_table;
}
void ChaCha20(char* message,int size,char* key,char* nonce){
    for(uint32_t i=0;i<(size+63)/64;i++){
        char* rand=ChaCha20_PRF(key,nonce,i);
        for(int j=0;j<64;j++){
            if(i*64+j>=size)break;
            message[i*64+j]^=rand[j];
        }
    }
}
#endif