#include <stdio.h>

int main(void)
{
    int longsize        = sizeof(long);
    int longlongsize    = sizeof(long long);
    int pointersize     = sizeof(void *);
    int integersize     = sizeof(int);

    char machinetype[20];
    int  pos = 0;

    printf("sizeof(int) = %d\n", integersize);
    printf("sizeof(long) = %d\n", longsize);
    printf("sizeof(long long) = %d\n", longlongsize);
    printf("sizeof(void *) = %d\n", pointersize);

    if (integersize == 8)
    {
        machinetype[pos] = 'I';
        pos++;
    }

    if (longsize == 8)
    {
        machinetype[pos] = 'L';
        pos++;
    }

    if (longlongsize == 8)
    {
        machinetype[pos] = 'L';
        pos++;
        machinetype[pos] = 'L';
        pos++;
    }

    if (pointersize == 8)
    {
        machinetype[pos] = 'P';
        pos++;
    }

    sprintf(machinetype + pos, "64");

    printf("machine type = %s\n", machinetype);

    return 0;
}

