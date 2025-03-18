In order to watch the proposed example, please run

    build.sh
If you want to see what's going on behind the scenes:

    bash -x build.sh

Feel free to suggest fixes and additional tests if needed.

Example output from my machine:

```
--- Original strings ---
Case 1: You have %d new messages.
  (with value): You have 5 new messages.

Case 2: Hello, %s!
  (with value): Hello, Alice!


Running with Spanish locale:
Current locale: en_IL
Locale directory: /home/yarons/Documents/workspace/gettext_demo/locale

--- Original strings ---
Case 1: Tienes mensajes nuevos.
  (with value): Tienes mensajes nuevos.

Case 2: ¡Hola!
  (with value): ¡Hola!
```

Thanks :)
