volatile unsigned int * const UART0DR = (unsigned int *) 0x101f1000;

void printUart(const char *s) {
    while(*s != '\0') {
        *UART0DR = (unsigned int)(*s);
        s++;
    }
}

int main(void) {

    printUart("Hello Qemu");

    while(1) {

    }

    return 0;
}
