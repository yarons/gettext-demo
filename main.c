// main.c
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <libintl.h>
#include <string.h>
#include <unistd.h>

// Define gettext macros
#define _(string) gettext(string)
#define PACKAGE "formattest"
#define LOCALEDIR "./locale"

int main() {
    int count = 5;
    char *name = "Alice";

    // Set up localization - ensure we have full path to locale directory
    char locale_path[1024];
    getcwd(locale_path, sizeof(locale_path));
    strcat(locale_path, "/locale");

    setlocale(LC_ALL, "");
    bindtextdomain(PACKAGE, locale_path);
    textdomain(PACKAGE);

    // Debug information
    printf("Current locale: %s\n", setlocale(LC_ALL, NULL));
    printf("Locale directory: %s\n\n", locale_path);

    // Test cases for format strings
    printf("--- Original strings ---\n");

    // Case 1: String with one numerical format specifier
    printf("Case 1: %s\n", _("You have %d new messages."));
    printf("  (with value): ");
    printf(_("You have %d new messages."), count);
    printf("\n\n");

    // Case 2: String with one string format specifier
    printf("Case 2: %s\n", _("Hello, %s!"));
    printf("  (with value): ");
    printf(_("Hello, %s!"), name);
    printf("\n\n");

    return 0;
}
