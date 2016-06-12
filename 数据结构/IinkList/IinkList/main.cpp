//
//  main.cpp
//  IinkList
//
//  Created by ZengChanghuan on 16/6/10.
//  Copyright © 2016年 ZengChanghuan. All rights reserved.
//
#include <stdio.h>
#include <stdlib.h>

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
#define ElemType int
struct ListNode
{
    ElemType data;
    struct ListNode *next;
};

ListNode *createListNode(int data)
{
    ListNode *node = (ListNode*)malloc(sizeof(ListNode));
    node->data = data;
    node->next = NULL;
    
    return node;
}

void CreateList(ListNode *head, int arrays[], int array_length)
{
    if (head == nullptr) {
        return;
    }
    
    ListNode *pcur = head;
    for (int i = 0; i < array_length;i++) {
        ListNode *node = createListNode(arrays[i]);
        pcur->next = node;
        pcur = pcur->next;
    }
    
}

void PrintLinkList(ListNode *head)
{
    if(head == nullptr || head->next == nullptr)
        return;
    
    ListNode *pcur = head->next;
    
    while(pcur) {
        printf("%d ", pcur->data);
        pcur = pcur->next;
    }
    printf("\n");
}

ListNode *FindElem(ListNode *head, ElemType e)
{
    if (head == nullptr || head->next == nullptr) {
        return nullptr;
        
    }
    //遍历指针，游标指针
    ListNode *pcur = head->next;
    while (pcur) {
        if (pcur->data == e) {
            return pcur;
        } else {
            pcur = pcur->next;
        }
    }
    return NULL;
}

//返回第i个元素的指针
ListNode *GetIthElemPointer(ListNode *head, int i)
{
    if (head == nullptr || head->next == nullptr || i < 0) {
        return NULL;
    }
    if (i == 0) {
        return head;
    }
    ListNode *pcur = head->next;
    int index = 1;
    while (pcur) {
        if (index < i) {
            pcur = pcur->next;
            index++;
        } else if (index == i) {
            return pcur;
        } else {
            break;
        }
    }
    
    return NULL;
}

// insert the elem to the position of the list
bool InsertElem(ListNode *head, int insert_position, int insert_elem)
{
    
    return true;
}

bool DeleteElem(ListNode *head, int delete_position)
{
    
    return true;
}

int main()
{
    int arrays[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int array_len = 10;
    
    ListNode *head = createListNode(-1);
    CreateList(head, arrays, array_len);
    PrintLinkList(head);
    
    /* Test FindElem */
    printf("Test FindElem, when input -1, exit\n");
    int find_elem;
    while(scanf("%d", &find_elem)) {
        if (find_elem == -1) {
            printf("end Test FindElem\n\n");
            break;
        }
        
        ListNode *pos = FindElem(head, find_elem);
        if (pos == NULL) {
            printf("The pos is NULL\n");
        } else {
            printf("The pos is %d %d\n", pos, pos->data);
        }
        
    }
    
    /* Test GetIthElemPointer */
    printf("Test GetIthElemPointer, when input -1, exit\n");
    int ith;
    while(scanf("%d", &ith)) {
        if (ith == - 1) {
            printf("end Test GetIthElemPointer\n\n");
            break;
        }
        
        ListNode *node = GetIthElemPointer(head, ith);
        if (node == NULL) {
            printf("ith is not exist\n");
        } else {
            printf("The ith elem is %d\n", node->data);
        }
        
    }
    
    
    /* Test InsertElem */
    printf("Test InsertElem, please input insert_position°¢insert_elem, when input -1 - 1, exit\n");
    int insert_position;
    int insert_elem;
    while(scanf("%d %d", &insert_position, &insert_elem)) {
        if (insert_position == -1 && insert_elem == -1) {
            printf("end Test InsertElem\n\n");
            break;
        }
        
        if (InsertElem(head, insert_position, insert_elem)) {
            printf("insert successs\naa");
            PrintLinkList(head);
        } else {
            printf("insert fail\n");
            
        }
    }
    
    
    /* Test DeleteElem */
    printf("Test DeleteElem, please input delete_position, when input - 1, exit\n");
    int delete_position;
    while(scanf("%d", &delete_position)) {
        if (delete_position == -1) {
            printf("end Test DeleteElem\n\n");
            break;
        }
        
        if (DeleteElem(head, delete_position)) {
            printf("delete successs\n");
            PrintLinkList(head);
        } else {
            printf("delete fail\n");
            
        }
    }
    
    
    
    
    return 0;
}

