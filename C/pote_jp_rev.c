#include <stdio.h>
void printJP(char *str){
    char t[]="テ";
    int c=0;
    for(int i=0;str[i]!='\0';i+=2){
        c<<=1;
        if(str[i]=t[0]&&str[i+1]==t[1]){
            c+=1;
        }
    }
    if(c<0b100000000)printf("%c",c);
    else {
        int mask=0xFF;
        char s[3];
        s[1]=c&mask;
        c>>=8;
        s[0]=c;
        s[2]='\0';
        printf("%s",s);
    }
}
int main(){
    char a[8*4+1];
    while(1){
        scanf("%s",&a);
        printJP(a);
        printf("\n");
    }
}
