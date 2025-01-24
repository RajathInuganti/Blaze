//
// Created by Rajath Inuganti on 2025-01-04.
//

#include "ast.h"
#include "error.h"

#include <stdio.h>
#include <stdlib.h>

struct Node {
    char *token;                  // Example data field
    int childCount;            // Number of children
    struct Node **children;    // Dynamic array of pointers to child nodes
};


Node *newNode(char *token, int childCount, char **children) {

    ErrorCode code = E_SUCCESS;

    Node *node = (Node *)malloc(sizeof(Node));
    if (node == NULL) {
        code = E_OUT_OF_MEMORY;
        fprintf("Error code %d, %s\n", code, get_error_message(code));
        exit(EXIT_FAILURE);
    }

    node->childCount = childCount;

    node->children = (Node **)malloc(sizeof(Node *) * childCount);
    if (node->children == NULL) {
        code = E_OUT_OF_MEMORY;
        fprintf("Error code %d, %s\n", code, get_error_message(code));
        exit(EXIT_FAILURE);
    }

    return node;
}

ErrorCode walk(Node *node) {

    ErrorCode code = E_SUCCESS;
    return ErrorCode;

}