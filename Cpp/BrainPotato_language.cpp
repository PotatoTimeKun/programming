#include <iostream>
#include <string>
using namespace std;
char a=0;
char* ptr=&a;
int l=0;
bool iftrue=false;
main(){
    cout<<"helpでヘルプを表示"<<endl;
    string inp;
    cin>>inp;
    if(inp=="help"){
        cout<<"Created by PotatoTimeKun https://github.com/PotatoTimeKun/programming \n最初のポインタのアドレスより前のアドレスは使用しないことを勧めます\n命令一覧:\np:ポインタのアドレスをインクリメント(ptr++)\no:ポインタのアドレスをデクリメント(ptr--)\nt:ポインタの値をインクリメント(*ptr+=1)\nm:ポインタの値をデクリメント(*ptr-=1)\nk:ポインタの値をASCII文字として出力\nu:ポインタの値が0ならnまで飛ばす\nn:ポインタの値が0以外ならuまで戻る\ni:ポインタの値が0ならaかe(eはaで閉じる)まで飛ばす\ne:iで飛ばされた場合のみaまで実行する\nc:ポインタの値を2倍する(*ptr*=2)\nh:ポインタの値を1/2倍する(*ptr/=2)\ns:キーボード入力を1文字受け取りポインタに格納する";
    }
    for(int i=0;i<inp.length();i++){
        char c=inp[i];
        switch (c)
        {
        case 'p':
            ptr++;
            break;
        case 'o':
            ptr--;
            break;
        case 't':
            *ptr+=1;
            break;
        case 'm':
            *ptr-=1;
            break;
        case 'k':
            cout<<*ptr;
            break;
        case 'u':
            if((int)*ptr==0){
                l=1;
                for(int j=i+1;j<inp.length();j++){
                    char c2=inp[j];
                    switch (c2){
                        case 'u':
                            l++;
                            break;
                        case 'n':
                            l--;
                            break;
                        default:
                            break;
                    }
                    if(l==0){
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'n':
            if((int)*ptr!=0){
                l=1;
                for(int j=i-1;j>=0;j--){
                    char c2=inp[j];
                    switch (c2){
                        case 'u':
                            l--;
                            break;
                        case 'n':
                            l++;
                            break;
                        default:
                            break;
                    }
                    if(l==0){
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'i':
            if((int)*ptr>0){
                iftrue=true;
            }else{
                iftrue=false;
                l=1;
                for(int j=i+1;j<inp.length();j++){
                    char c2=inp[j];
                    switch (c2){
                        case 'm':
                            l--;
                            break;
                        case 'e':
                            l--;
                            break;
                        default:
                            break;
                    }
                    if(l==0){
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'a':
            break;
        case 'e':
            if(iftrue){
                l=1;
                for(int j=i+1;j<inp.length();j++){
                    char c2=inp[j];
                    switch (c2){
                        case 'm':
                            l--;
                            break;
                        default:
                            break;
                    }
                    if(l==0){
                        i=j;
                        break;
                    }
                }
            }
            break;
        case 'c':
            *ptr*=2;
            break;
        case 'h':
            *ptr/=2;
            break;
        case 's':
            cin>>*ptr;
            break;
        default:
            break;
        }
    }
}