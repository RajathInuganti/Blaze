#include "error.h"
#include <stddef.h> /* for NULL */

static const char *error_messages[] = {
    [E_SUCCESS]          = "No error.",
    [E_INVALID_ARGUMENT] = "Invalid argument.",
    [E_OUT_OF_MEMORY]    = "Out of memory.",
    [E_FILE_NOT_FOUND]   = "File not found.",
    /* ... add more as needed */

    [E_UNKNOWN]          = "Unknown error."
};


const char *get_error_message(ErrorCode code)
{

    if (code >= 0 && code < E_UNKNOWN) {
        return error_messages[code];
    } else {
        return error_messages[E_UNKNOWN];
    }

}