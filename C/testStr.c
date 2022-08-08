#include <stdio.h>
#include "mystr.h"
int main(){
    string* str=makeStr(); // 文字列の作成
    printf("a=");
    scanStr(str); // 文字列のキーボード入力
    printf("a\'s length=");
    printf("%d\n",str->len); // 長さの取得
    string* str2=makeStr();
    printf("b=");
    scanStr(str2);
    printf("b\'s length=");
    printf("%d\n",str2->len);
    string* str3=sumStr(str,str2); // 文字列の足し算
    printf("a+b=");
    printStr(str3);
    printf("\nlength of a+b=");
    printf("%d\n",str3->len);
    addStr(str,str2);
    printf("a+=b;a=");
    printStr(str);
    printf("\na\'s length=");
    printf("%d\n",str->len);
    string* sStr=subStr(str,1,4);
    printf("a=a[1:4]=");
    printStr(sStr);
    printf("\na\'s length=");
    printf("%d\n",sStr->len);
    char s[100];
    printf("char[100] c=");
    scanf("%[^\n]",&s);
    string* sToStr=charsToStr(s);
    printf("(string)c=");
    printStr(sToStr);
    printf("\nlength of (string)c=");
    printf("%d\n",sToStr->len);
    char* sToStrToChars=strToChars(sToStr);
    printf("(char*)( (string)c )=");
    printf("%s",sToStrToChars);
    printf("\n(string)c[2]=%c",atStr(sToStr,2));
    printf("\ndel (string)c[2];deleted=%c",delAtStr(sToStr,2));
    printf("\ndelete c[0]~c[1]");
    delStr(sToStr,0,2);
    printf("\n(string)c=");
    printStr(sToStr);
    printf("\nd(\"%%s\")=");
    string* str4=makeStr();
    scanStrPs(str4);
    printf("d=");
    printStr(str4);
    printf("\ne(Integer number)=");
    string* str5=makeStr();
    scanStrPs(str5);
    printf("(int)e=%d",strToInt(str5));
    printf("\nf(number)=");
    string* str6=makeStr();
    scanStrPs(str6);
    printf("(float)f=%f\n",strToFloat(str6));
    string* str7=makeStr();
    printf("g=");
    scanStr(str7);
    printf("g's index(abc):%d",indexStr(str7,charsToStr("abc")));
    printfStr("\n\"%f and %g\",f,g=%S and %S",str6,str7);
    printfs("\nf=%S,g=%S,len(f)=%d,len(g)=%f",str6,str7,str6->len,str7->len);
    reverseStr(str6);
    printfs("\nf=reversed f=%S",str6);
    setStr(str7,'a',1);
    addStrC(str7,'b');
    printfs("\ng[1]=\'a\',g+=\'b\'\ng=%S",str7);
    addAtStr(str7,str6,2);
    printfs("\ng=g[:2]+f+g[2:]=%S",str7);
}
