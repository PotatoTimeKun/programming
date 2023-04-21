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
}