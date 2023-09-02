#ifndef INCLUDE_CIPHER2
#define INCLUDE_CIPHER2
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

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

void theta(uint64_t inner[5][5]){
    uint64_t C[5];
    for(int i=0;i<5;i++){
        uint64_t tmp=inner[i][0];
        for(int j=1;j<4;j++) tmp=tmp^inner[i][j];
        C[i]=tmp;
    }
    uint64_t D[5];
    for(int i=0;i<5;i++){
        D[i]=C[(i+4)%5]^((C[(i+1)%5]>>1)|(C[(i+1)%5]<<63));
    }
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++) inner[i][j]=inner[i][j]^C[i];
    }
}

void rho(uint64_t inner[5][5]){
    uint64_t tmp[5][5];
    tmp[0][0]=inner[0][0];
    int x=0,y=0;
    for(int t=0;t<23;t++){
        int move=((t+1)*(t+2)/2)%64;
        tmp[x][y]=(inner[x][y]>>move)|(inner[x][y]<<(64-move));
        int tmpX=x;
        x=y;
        y=(2*tmpX+3*y)%5;
    }
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++) inner[i][j]=tmp[i][j];
    }
}

void pi(uint64_t inner[5][5]){
    uint64_t tmp[5][5];
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++) tmp[i][j]=inner[(i+3*j)%5][i];
    }
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++) inner[i][j]=tmp[i][j];
    }
}

void khi(uint64_t inner[5][5]){
    uint64_t tmp[5][5];
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++) tmp[i][j]=inner[i][j]^((~inner[(i+1)%5][j])&inner[(i+2)%5][j]);
    }
    for(int i=0;i<5;i++){
        for(int j=0;j<5;j++) inner[i][j]=tmp[i][j];
    }
}

uint8_t rc(int t){
    uint8_t R=0b10000000;
    for(int i=0;i<=t%255;i++){
        uint8_t R0=0,R4,R5,R6;
        R0=(R0)^(R<<7);
        R4=(R<<3)^(R<<7);
        R5=(R<<4)^(R<<7);
        R6=(R<<5)^(R<<7);
        R=(R0<<7)|((R4&0b1000000)>>4)|((R5&0b1000000)>>5)|((R6&0b1000000)>>6)|((R&0b11100011)>>1);
    }
    return R;
}

void iota(uint64_t inner[5][5],int ir){
    uint64_t RC=0;
    int pow2=1;
    for(int j=0;j<=6;j++){
        uint8_t musk8=rc(j+7*ir)>>7;
        uint64_t musk=0;
        if(musk8==1)musk=1<<pow2;
        RC=RC&(~(1<<pow2))|musk;
        pow2*=2;
    }
    inner[0][0]=inner[0][0]^RC;
}

void sha_3_256(char* data,int dataLen,char* returnArray){
    char block[136];
    char S[200]={0};
    for(int i=0;i<=(dataLen+1)/136;i++){
        int paddingStart=0;
        for(int j=0;j<136;j++){
            if(paddingStart)block[j]=0;
            if(j==135)block[j]=1;
            if(j==135&&!paddingStart)block[j]=0b10000001;
            else if(!paddingStart && 136*i+j>=dataLen){
                block[j]=0b10000000;
                paddingStart=1;
            }
            else block[j]=data[136*i+j];
            S[j]=S[j]^block[j];
        }
        uint64_t inner[5][5];
        for(int j=0;j<5;j++){
            for(int k=0;k<5;k++){
                inner[j][k]=0;
                for(int l=0;l<8;l++){
                    inner[j][k]=inner[j][k]|(((uint64_t)S[5*8*j+8*k+l])<<(8*l));
                }
            }
        }
        for(int j=0;j<24;j++){
            theta(inner);
            rho(inner);
            pi(inner);
            khi(inner);
            iota(inner,j);
        }
        for(int j=0;j<5;j++){
            for(int k=0;k<5;k++){
                for(int l=0;l<8;l++){
                    S[5*8*j+8*k+l]=(char)(inner[i][j]>>(7-l));
                }
            }
        }
    }
    for(int i=0;i<32;i++)returnArray[i]=S[i];
}

#endif