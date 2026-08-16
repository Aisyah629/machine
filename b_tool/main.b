/* main.b - Low-level string manipulation and file I/O utility suite */

/* B Language Implementation */

/* Utility: Read a line from standard input */
readln() {
    char buf[80];
    int i;
    for (i = 0; i < 79 && (buf[i] = getchar()) != '\n' && buf[i] != EOF; i++)
        ;
    buf[i] = '\0';
    return 0;
}

/* Utility: Compare two strings */
strcmp(s1, s2) {
    char *p1 = s1;
    char *p2 = s2;
    while (*p1 && *p2 && *p1 == *p2) {
        p1++;
        p2++;
    }
    return *p1 - *p2;
}

/* Utility: Concatenate two strings into destination */
strcat(dest, src) {
    char *d = dest;
    char *s = src;
    while (*d)
        d++;
    while (*d++ = *s++)
        ;
    return 0;
}

/* Utility: Write a string to standard output */
writeln(s) {
    char *p = s;
    while (*p)
        putchar(*p++);
    putchar('\n');
    return 0;
}

/* Main Entry Point */
main() {
    char input[80];
    char output[160];
    char base[] = "Tool Initialized: ";

    writeln("B Tool - String & I/O Utility Suite");
    writeln("Enter a string: ");
    readln(input);
    
    strcat(base, input);
    strcat(base, " [Processed]");
    
    writeln("Output:");
    writeln(base);

    return 0;
}
