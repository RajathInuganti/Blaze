#ifndef ERROR_H
#define ERROR_H

typedef enum {
    E_SUCCESS = 0,
    E_INVALID_ARGUMENT,
    E_OUT_OF_MEMORY,
    E_FILE_NOT_FOUND,
    /* ... add more as needed */

    E_UNKNOWN
} ErrorCode;


const char *get_error_message(ErrorCode code);

#endif
