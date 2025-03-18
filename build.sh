#!/bin/bash

# Create directory structure
mkdir -p locale/es/LC_MESSAGES

# Generate the MO file from the PO file
msgfmt -o locale/es/LC_MESSAGES/{formattest.mo,es.po}

# Compile the program - using pkg-config to find the correct flags for gettext
if command -v pkg-config &> /dev/null; then
    # Use pkg-config if available
    GETTEXT_CFLAGS=$(pkg-config --cflags gettext)
    GETTEXT_LIBS=$(pkg-config --libs gettext)
    gcc -o formattest main.c $GETTEXT_CFLAGS $GETTEXT_LIBS
else
    # Try different approaches if pkg-config is not available
    # Option 1: Link against libintl directly (common on many systems)
    gcc -o formattest main.c -lintl && echo "Compiled with -lintl" && exit 0

    # Option 2: Try with gettext library (some systems use this naming)
    gcc -o formattest main.c -lgettext && echo "Compiled with -lgettext" && exit 0

    # Option 3: On macOS with Homebrew or on some Linux distros, try this path
    gcc -o formattest main.c -I/usr/local/include -L/usr/local/lib -lintl && echo "Compiled with explicit paths" && exit 0

    # Option 4: On systems where gettext functions are included in libc (like glibc-based systems)
    gcc -o formattest main.c && echo "Compiled without explicit linking" && exit 0

    # If we got here, all compilation attempts failed
    echo "Failed to compile. You may need to install gettext development files."
    echo "Try: sudo apt-get install gettext (Debian/Ubuntu)"
    echo "  or: sudo yum install gettext-devel (Fedora/CentOS)"
    echo "  or: brew install gettext && brew link gettext --force (macOS)"
    exit 1
fi

# Run the program with default locale
echo "Running with default locale:"
./formattest

# Run the program with Spanish locale
echo -e "\nRunning with Spanish locale:"
# Try several locale settings to ensure one works
LANGUAGE=es_ES ./formattest
