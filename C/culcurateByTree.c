#include <stdio.h>
#include "tree.h"
#include "mystr.h"

/**
 * @brief 中置記法の計算式から先頭の演算子または項(括弧で囲まれたものも1つの項とする)を取り出します
 * 
 * @param str string*
 * @return string* 
 */
string* getElement(string* str){
    string* element=makeStr();
    if(atStr(str,0)=='+'||atStr(str,0)=='-'||atStr(str,0)=='*'||atStr(str,0)=='/'){
        addStrC(element,atStr(str,0));
        return element;
    }
    int bracket=0;
    for(int i=0;i<str->len;i++){
        char str_i=atStr(str,i);
        if(bracket==0 && (str_i=='+'||str_i=='-'||str_i=='*'||str_i=='/'))return element;
        if(str_i=='(')bracket++;
        if(str_i==')')bracket--;
        addStrC(element,str_i);
    }
    return element;
}

/**
 * @brief 中置記法の四則演算計算式を2分木で表現します
 * 
 * @param str string*
 * @return Tree* 
 */
Tree* formulaToTree(string* str){
    string* formula=copyStr(str);
    Tree *tree=newTree(),*left,*right;
    // 一番先頭の要素だけ取り出す
    string* element=getElement(formula);
    if(atStr(element,0)=='(')
        tree=formulaToTree(subStr(element,1,element->len-1));
    else
        tree->root=element;
    formula=subStr(formula,element->len,formula->len);
    while(formula->chars->value!='\0'){
        // 今までのtreeが左部分木になる
        left=tree;
        tree=newTree();
        // 演算子を取り出す
        element=getElement(formula);
        formula=subStr(formula,element->len,formula->len);
        tree->leftTree=left;
        tree->root=element;
        // 右部分木を取り出す
        if(atStr(element,0)=='*'||atStr(element,0)=='/'){ // 演算子の優先度で分岐
            // 次の項が右部分木
            element=getElement(formula);
            formula=subStr(formula,element->len,formula->len);
            if(atStr(element,0)=='(')right=formulaToTree(subStr(element,1,element->len-1));
            else{
                right=newTree();
                right->root=element;
            }
        }else{
            // +,-以外で繋がれた式が右部分木
            element=makeStr();
            while(formula->chars->value!='\0' && formula->chars->value!='+' && formula->chars->value!='-'){
                string* addElement=getElement(formula);
                addStr(element,addElement);
                formula=subStr(formula,addElement->len,formula->len);
            }
            right=formulaToTree(element);
        }
        tree->rightTree=right;
    }
    return tree;
}

/**
 * @brief 2分木で表現された計算式を逆ポーランド記法(後置記法)で返します
 * 
 * @param tree Tree*
 * @return string* 
 */
string* treeToRPN(Tree* tree){
    setNotFollowed(tree);
    stackInit(stacksize);
    push(tree);
    Tree* subtree;
    string *rpn=makeStr();
    while(tree->followed==0){ // 後行順
        subtree=pop();
        if(subtree->followed==0)push(subtree);
        if(subtree->rightTree!=NULL){
            if(subtree->rightTree->followed==0)
                push(subtree->rightTree);
        }
        if(subtree->leftTree!=NULL){
            if(subtree->leftTree->followed==0){
                push(subtree->leftTree);
                continue;
            }
        }
        if(subtree->rightTree!=NULL){
            if(subtree->rightTree->followed==0)
                continue;
        }
        if(subtree->followed)continue;
        subtree->followed=1;
        addStr(rpn,subtree->root);
    }
    free(stack);
    return rpn;
}

/**
 * @brief 2分木で表現された計算式をポーランド記法(前置記法)で返します
 * 
 * @param tree Tree*
 * @return string* 
 */
string* treeToPN(Tree* tree){
    stackInit(stacksize);
    push(tree);
    Tree* subtree;
    string *pn=makeStr();
    while(stackPointer!=0){ // 先行順
        subtree=pop();
        addStr(pn,subtree->root);
        if(subtree->rightTree!=NULL)push(subtree->rightTree);
        if(subtree->leftTree!=NULL)push(subtree->leftTree);
    }
    free(stack);
    return pn;
}

int main(){
    string* formula=makeStr();
    printf("※四則演算のみ,演算子の省略なし,負符号なし(-aは0-aとして書く)\n式:");
    scanStr(formula);
    if(checkDyck(formula,'(',')')==0){
        printf("括弧が対応していません\n");
        main();
        return 0;
    }
    while(indexStrC(formula," ")!=-1)delAtStr(formula,indexStrC(formula," "));
    Tree* tree=formulaToTree(formula);
    string* rpn=treeToRPN(tree);
    printfStr("逆ポーランド記法 -> %S\n",rpn);
    string* pn=treeToPN(tree);
    printfStr("ポーランド記法   -> %S\n",pn);
}