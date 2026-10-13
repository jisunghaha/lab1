#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

typedef double (*operation)(double, double);

int main(void)
{
    void *handle = dlopen("./lib/libcalc.so", RTLD_NOW);

    if (handle == NULL) {
        fprintf(stderr, "%s\n", dlerror());
        return EXIT_FAILURE;
    }

    const char *names[] = {
        "add", "subtract", "multiply", "divide"
    };

    for (int i = 0; i < 4; i++) {
        dlerror();

        operation func = (operation)dlsym(handle, names[i]);
        const char *error = dlerror();

        if (error != NULL) {
            fprintf(stderr, "%s\n", error);
            dlclose(handle);
            return EXIT_FAILURE;
        }

        printf("%s: %.2f\n", names[i], func(20, 4));
    }

    if (dlclose(handle) != 0) {
        fprintf(stderr, "%s\n", dlerror());
        return EXIT_FAILURE;
    }

    return 0;
}
