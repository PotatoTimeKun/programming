#include <stdio.h>
#include <stdlib.h>
#include "mystr.h"

#ifndef INCLUDE_TREE
#define INCLUDE_TREE

/**
 * @brief 2分木を扱います、インデックスは先行順で決めます
 */
typedef struct treestruct
{
    string* root;
    struct treestruct* leftTree;
    struct treestruct* rightTree;
    int followed;
} Tree;

Tree* newTree(){
    Tree *tree=(Tree*)malloc(sizeof(Tree));
    tree->leftTree=NULL;
    tree->rightTree=NULL;
    return tree;
}

Tree* getLeftTree(Tree* tree){
    return tree->leftTree;
}

Tree* getRightTree(Tree* tree){
    return tree->rightTree;
}

#define stacksize 1000

Tree** stack;
int stackPointer=0;

void stackInit(int size){ // スタックの初期化
    stack=(Tree**)malloc(size*sizeof(Tree*));
    stackPointer=0;
}

void push(Tree* data){ // スタックへプッシュ
    stack[stackPointer++]=data;
}
Tree* pop(){ // スタックからポップ
    return stack[--stackPointer];
}

Tree* getSubtree(Tree* tree,int index){
    stackInit(stacksize);
    push(tree);
    Tree* subtree=tree;
    for(int i=0;i<=index;i++){
        if(stackPointer==0)break;
        subtree=pop();
        if(subtree->rightTree!=NULL)push(subtree->rightTree);
        if(subtree->leftTree!=NULL)push(subtree->leftTree);
        if(stackPointer==0)break;
    }
    free(stack);
    return subtree;
}

void deleteTree(Tree* tree){
    stackInit(stacksize);
    push(tree);
    Tree* subtree=tree;
    while(1){
        if(stackPointer==0)break;
        subtree=pop();
        if(subtree->rightTree!=NULL)push(subtree->rightTree);
        if(subtree->leftTree!=NULL)push(subtree->leftTree);
        free(subtree);
    }
    free(stack);
}

void setNotFollowed(Tree* tree){
    stackInit(stacksize);
    push(tree);
    Tree* subtree=tree;
    while(stackPointer!=0){
        subtree=pop();
        if(subtree->rightTree!=NULL)push(subtree->rightTree);
        if(subtree->leftTree!=NULL)push(subtree->leftTree);
        subtree->followed=0;
    }
    free(stack);
}

int addLeftChild(Tree* tree,int index,string* child){
    Tree* addedTree=newTree();
    addedTree->root=child;
    Tree* subtree=getSubtree(tree,index);
    if(subtree==NULL)return 0;
    if(subtree->leftTree!=NULL)return 0;
    subtree->leftTree=addedTree;
    return 1;
}

int addRightChild(Tree* tree,int index,string* child){
    Tree* addedTree=newTree();
    addedTree->root=child;
    Tree* subtree=getSubtree(tree,index);
    if(subtree==NULL)return 0;
    if(subtree->rightTree!=NULL)return 0;
    subtree->rightTree=addedTree;
    return 1;
}

int addChild(Tree* tree,int index,string* child){
    int success=1;
    if(addLeftChild(tree,index,child)==0)success=addRightChild(tree,index,child);
    return success;
}

int addLeftTree(Tree* tree,int index,Tree* addedTree){
    Tree* subtree=getSubtree(tree,index);
    if(subtree==NULL)return 0;
    if(subtree->leftTree!=NULL)return 0;
    subtree->leftTree=addedTree;
    return 1;
}

int addRightTree(Tree* tree,int index,Tree* addedTree){
    Tree* subtree=getSubtree(tree,index);
    if(subtree==NULL)return 0;
    if(subtree->rightTree!=NULL)return 0;
    subtree->rightTree=addedTree;
    return 1;
}

int addTree(Tree* tree,int index,Tree* addedTree){
    int success=1;
    if(addLeftTree(tree,index,addedTree)==0)success=addRightTree(tree,index,addedTree);
    return success;
}

#endif