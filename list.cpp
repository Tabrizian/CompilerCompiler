#include "list.h"

#include <cstdlib>
#include <cstdio>

struct node* create_node(int data)
{
    struct node *result = (struct node *) malloc(sizeof(struct node));
    result->data = data;
    result->link = NULL;
    return result;
}
//Recursive
int size_of(struct node* first)
{
    if(first == NULL)
        return 0;
    else
        return (size_of(first->link) + 1);
}

void add_end(struct node * first, int data)
{
    struct node *current;
    for(current = first; current->link != NULL; current = current->link);
    struct node *new_node = create_node(data);
    current->link = new_node;
}

void print_list(struct node *first)
{
    struct node *current;
    for(current=first; current!=NULL; current=current->link)
    {
        printf("Node %d\n", current->data);
    }
}

void add_front(struct node** first,int data)
{
    struct node* new_node = create_node(data);
    new_node->link =*first;
    *first = new_node;
}

void delete_end(struct node* first)
{
    struct node* current;
    for(current = first; current->link->link!=NULL; current=current->link);
    free(current->link);
    current->link=NULL;
}

void delete_front(struct node** first)
{
    struct node* new_first = (*first)->link;
    free(*first);
    *first = new_first;
}

void insert_next_node(struct node* current_node,int data)
{
    struct node* new_node = create_node(data);
    struct node* next = current_node->link;
    current_node->link = new_node;
    new_node->link = next;
}
void remove_item(struct node** first,int data)
{
    struct node* current = *first;
    if(current->data == data)
    {
        delete_front(first);
        current = *first;
    }
    for(current; current->link!=NULL; current=current->link)
    {
        if(current->link->data == data)
        {
            struct node *next = current->link->link;
            free(current->link);
            current->link = next;
            if(current->link == NULL)
                return;
        }

    }

}
//Except the first node
void delete_node(struct node* before_delete_node)
{
    struct node* deleted = before_delete_node->link;
    struct node* next = before_delete_node->link->link;
    free(deleted);
    before_delete_node->link = next;
}

struct node* merge_lists(struct node *first_x,struct node *first_y)
{
    if(first_x == NULL) return first_y;
    if(first_y == NULL) return first_x;
    struct node* result;
    if(first_x->data >= first_y->data)
        result = first_y;
    else
        result = first_x;
    struct node * temp = NULL;
    while(first_x!=NULL && first_y!=NULL)
    {
        /*cout<<first_x->data<<" "<<first_y->data;
        if(temp==NULL)
            cout<<" "<<"NULL"<<endl;
        else
            cout<<" "<<temp->data<<endl;
        */
        for(; first_x->link&&first_x->link->data<first_y->data; first_x=first_x->link);
        for(; first_y->link&&first_y->link->data<first_x->data; first_y=first_y->link);
        if(first_x->data>=first_y->data)
        {
            temp = first_y;
            first_y = first_y->link;
            temp->link=first_x;
        }
        else
        {
            temp = first_x;
            first_x = first_x->link;
            temp->link = first_y;
        }
    }

    return result;
}
