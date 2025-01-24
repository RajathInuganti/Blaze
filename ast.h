//
// Created by Rajath Inuganti on 2025-01-04.
//

#ifndef AST_H
#define AST_H

#include "error.h"

#include <stddef.h>

typedef struct Node Node;

Node *newNode(char *token, int childCount, char **children);

ErrorCode walk(Node *node);

#endif //AST_H
