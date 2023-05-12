#include <stdint.h>
#include <stdio.h>
void showBinary32(uint8_t binary32[]){
    // 配列をそのまま表示
    for(int i=0;i<4;i++){
        uint8_t dev2=128;
        for(int j=0;j<8;j++){
            printf("%d",(binary32[i]&dev2)?1:0);
            dev2/=2;
        }
        printf(" ");
    }
    printf("\n");
    char sign=binary32[0]>>7==0?'+':'-';
    uint8_t e=(binary32[0]<<1)+(binary32[1]>>7);
    uint8_t m[3]; // 仮数(第1桁の1も含む)
    for(int i=0;i<3;i++)m[i]=binary32[i+1];
    m[0]=(e==0||e==255?0:1)<<7|(m[0]&0b01111111);
    // NaNまたは±Infのとき
    if(e==255){
        for(int i=0;i<3;i++){
            if(m[i]==0)continue;
            printf("=NaN\n");
            return;
        }
        printf("=%cInf\n",sign);
        return;
    }
    // 具体的な数値を持つとき
    // 符号 仮数*指数の形式で表示
    printf("=bin:%c",sign);
    for(int i=0;i<3;i++){
        uint8_t dev2=128;
        for(int j=0;j<8;j++){
            printf("%d",(m[i]&dev2)?1:0);
            if(i==0&&j==0)printf(".");
            dev2/=2;
        }
        printf(" ");
    }
    printf(" * 2^%d\n",(int)e-127);
    // 値を表示
    printf("=bin:%c",sign);
    int charCount=0;
    int dotPos=(int)e-127; //=指数(イクセス表現を外したもの)
    if(e==0)dotPos++;
    if(dotPos<0){
        printf("0.");
        charCount++;
        for(int i=0;i<-dotPos-1;i++){
            printf("0");
            if(++charCount%8==0)printf(" ");
        }
    }
    for(int i=0;i<3;i++){
        uint8_t dev2=128;
        for(int j=0;j<8;j++){
            printf("%d",(m[i]&dev2)?1:0);
            if(8*i+j==dotPos)printf(".");
            if(++charCount%8==0)printf(" ");
            dev2/=2;
        }
    }
    if(dotPos>23){
        for(int i=0;i<dotPos-23;i++){
            printf("0");
            if(++charCount%8==0)printf(" ");
        }
    }
    printf("\n");
}
int main(){
    uint8_t bin[4]={0b01111111u,0b01111111u,0b11111111u,0b11111111u};
    // binary32において最大値を取るとき
    // 符号s=0(+)
    // 指数e=254(->127)
        // (eの最大は255だが、このとき数値ではない(NaNもしくは±Inf))
    // 仮数mは全て1で埋める
    showBinary32(bin);
}