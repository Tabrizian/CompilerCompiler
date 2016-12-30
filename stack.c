
#include <stdlib.h>
#include <string.h>

#include "stack.h"

struct stack *stack_create(void)
{
    struct stack *ret;

    ret = malloc(sizeof(struct stack));
    ret->top = NULL;

    return ret;
}

void stack_push(struct stack *stack, const void *source, size_t type_size)
{
    struct node *new_node;

    new_node = malloc(sizeof(struct node));
    new_node->data = malloc(type_size);
    new_node->next = NULL;

    memcpy(new_node->data, source, type_size);

    new_node->next = stack->top;
    stack->top = new_node;
}

void stack_pop(struct stack *stack, void *sink, size_t type_size)
{
    struct node *old_node;

    old_node = stack->top;
    stack->top = stack->top->next;

    memcpy(sink, old_node->data, type_size);
}
