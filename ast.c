//
// Created by Rajath Inuganti on 2025-01-04.
//

#include "ast.h"

#include <stdio.h>
#include <stdlib.h>

struct Node {
    int data;                  // Example data field
    int childCount;            // Number of children
    struct Node **children;    // Dynamic array of pointers to child nodes
};

Node *newNode(int data) {

}