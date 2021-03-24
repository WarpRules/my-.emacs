This is a simplified and cleaned-up version of my .emacs file which I have been refining for the past decades, to make Emacs easier to use.

It configures the following things:
* `delete-selection-mode`: Makes Emacs behave more like other (especially Windows) editors: Select text with shift+cursor movement, delete it with the del key, ctrl+ins to copy, shift+ins to paste, shift+del to delete, etc.
* Small miscellaneous interface and behavior configurations, such as scrolling one line at a time (instead of half a page), hide the toolbar in GUI emacs, elide autosaves, etc.
* Several changes to many keys and shortcuts, as well as adding new shortcuts, such as making page-up and page-down keep the cursor on its visual position (rather than jumping to the top or the bottom of the window), support for scrolling with ctrl-down and ctrl-up (moving the cursor to the next/prev line), alt-down and alt-up (keeping the cursor at its current line), etc.
* My own code coloring and autoindentation settings.

Check the contents of the file itself for all the details (and to comment out anything you don't like.)
