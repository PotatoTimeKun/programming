#include <stdio.h>
#include "new_tabaicho.h"

int main(){
    Tabaicho* tab;
    Tabaicho* tab2;
    printf("a=");
    tab=inputTabaicho();
    printf("b=");
    tab2=inputTabaicho();
    switch(cmp(tab,tab2)){
        case -1:
            printf("a<b\n");
            break;
        case 0:
            printf("a==b\n");
            break;
        case 1:
            printf("a>b\n");
            break;
    }
    Tabaicho* tab3=sum(tab,tab2);
    printf("a+b=");
    showTabaicho(tab3);
    delList(tab3);
    tab3=sub(tab,tab2);
    printf("a-b=");
    showTabaicho(tab3);
    delList(tab3);
    tab3=mul(tab,tab2);
    printf("a*b=");
    showTabaicho(tab3);
    delList(tab3);
    tab3=divi(tab,tab2);
    printf("a/b=");
    outputLongInt(tab3);
    delList(tab);
    delList(tab2);
    delList(tab3);
}