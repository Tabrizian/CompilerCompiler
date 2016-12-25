#ifndef CHILD_H
#define CHILD_H

struct node {
    int data;
    struct node *link;
};

struct node* create_node(int data);

int size_of(struct node* first);

void add_end(struct node * first, int data);

void print_list(struct node *first);

void add_front(struct node** first, int data);

void delete_end(struct node* first);

void delete_front(struct node** first);

void insert_next_node(struct node* current_node, int data);

void remove_item(struct node** first, int data);

void delete_node(struct node* before_delete_node);

struct node* merge_lists(struct node *first_x, struct node *first_y);

#endif
