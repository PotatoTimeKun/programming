#include <stdio.h>
#include "Cipher2.h"
void printMessage(char* message,int size){
    printf("%s\n(",message);
    for(int i=0;i<size;i++){
        for(int j=0;j<8;j++)printf("%d",(message[i]>>j)&1);
        printf(" ");
    }
    printf(")\n");
}
int main(){
    char message[18]="this is a message";
    char key[33]="needa32Byteskeyformakethiscipher";
    char nonce[13]="nonceis96bit";
    printf("plaintext:\n");
    printMessage(message,17);
    ChaCha20(message,17,key,nonce);
    printf("\nencode:\n");
    printMessage(message,17);
    ChaCha20(message,17,key,nonce);
    printf("\ndecode:\n");
    printMessage(message,17);
    char sha[32];
    sha_3_256(message,18,sha);
    printf("SHA-3-256(\"%s\")=0b\n",message);
    for(int i=0;i<32;i++){
        for(int j=0;j<8;j++){
            printf("%c",(sha[i]>>(7-j))%2==0?'0':'1');
        }
        printf(" ");
        if(i%5==4)printf("\n");
    }
    message[0]+=1;
    sha_3_256(message,18,sha);
    printf("\n\nSHA-3-256(\"%s\")=0b\n",message);
    for(int i=0;i<32;i++){
        for(int j=0;j<8;j++){
            printf("%c",(sha[i]>>(7-j))%2==0?'0':'1');
        }
        printf(" ");
        if(i%5==4)printf("\n");
    }
}