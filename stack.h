#ifndef STACK_H
#define STACK_H

struct node {
	void *data;
	struct node *next;
};

struct stack {
	struct node *top;
};

struct stack *stack_create(void);

void stack_push(struct stack *stack, const void *source, size_t type_size);

void stack_pop(struct stack *stack, void *sink, size_t type_size);

#endif
