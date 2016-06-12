//
//  main.cpp
//  list
//
//  Created by ZengChanghuan on 16/6/10.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//
#include <stdio.h>

#define ElemType int

#define MAXSIZE 100
typedef struct
{
    ElemType data[MAXSIZE];
    int length;
}SqList;


void PrintSqList(SqList *L)
{
    for (int i = 0; i < L->length;i++) {
        printf("%d ",L->data[i]);
    }
    printf("\n");
    
    
}

bool isEmpty(SqList *L)
{
    if (L->length == 0) {
        return true;
    } else {
        return false;
    }
}

int FindElem(SqList *L, ElemType e)
{
    for (int i = 0; i < L->length; i++) {
        if (e == L->data[i]) {
            return i+1;
        }
    }
    return 0;
}

// insertpos: start form 1
bool InsertElem(SqList &L, int insertpos, ElemType e)
{
    //1.判断输入参数合法性
    if (insertpos < 1 || insertpos > L.length) {
        return false;
    }
    //2.确定上下界
    for (int i = L.length; i >= insertpos+1; i--) {
        L.data[i] = L.data[i-1];
        
    }
    
    //3.赋值
    L.data[insertpos] = e;
    
    //4.长度改变
    L.length++;
    
    
    return true;
}

bool RemoveElem(SqList &L, int removepos)
{
    //1.判断输入参数合法性
    if (removepos < 1 ||  removepos > L.length) {
        return false;
    }
    //确定上下界
    for (int i = removepos;i <= L.length-1;i++) {
        L.data[i-1] = L.data[i];
    }
    if (L.length > 0) {
        L.length--;

    }
    return true;
}

int main()
{
    int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    
    SqList sqlist;
    sqlist.length = 0;
    
    for (int i = 0; i < 10; i++) {
        sqlist.data[i] = a[i];
        sqlist.length = i + 1;
    }
    
    PrintSqList(&sqlist);
    
    /* Test findElem */
    printf("Test FindElem, when input -1, exit\n");
    int find_elem;
    while(scanf("%d", &find_elem)) {
        if (find_elem == -1) {
            printf("end Test FindElem\n\n");
            break;
        }
        
        printf("The pos is %d\n", FindElem(&sqlist, find_elem));
    }
    
    /* Test InsertElem */
    printf("Test InsertElem, when input -1 -1, exit\n");
    int insert_pos;
    int insert_elem;
    
    while(scanf("%d %d", &insert_pos, &insert_elem)) {
        if (insert_pos == -1 && insert_elem == -1) {
            printf("end Test InsertElem\n\n");
            break;
        }
        
        if (InsertElem(sqlist, insert_pos, insert_elem)) {
            printf("insert success\n");
            PrintSqList(&sqlist);
        } else {
            printf("insert fail\n");
        }
    }
    
    /* Test RemoveElem */
    printf("Test RemoveElem, when input -1, exit\n");
    int removepos;
    while (scanf("%d", &removepos)) {
        if (removepos == -1) {
            printf("end Test RemoveElem\n\n");
            break;
        }
        if (RemoveElem(sqlist, removepos)) {
            printf("remove success\n");
            PrintSqList(&sqlist);
        } else {
            printf("remove fail\n");
        }
    }
    
    return 0;
}
