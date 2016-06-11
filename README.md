# ntbc #

This is a tiny program that allows you to to tweak the level' background colors and shadow colors in Nuclear Throne' update 98.

Something that you may want if you are doing a texture mod for the game.

### How to use ###

1. [Download](https://bitbucket.org/yal_cc/ntbc/downloads) the repository.
2. Unzip the downloaded file somewhere.
3. Open "bin" directory, shift+right click on an empty space, and pick "Open command window here". An usual command\console window should pop up.
4. Right-click Nuclear Throne in Steam, pick "Properties", tab "Local files", button "Browse local files...". An Explorer window should 
5. Shift+right click the `data.win` file, pick "Copy as path".
6. Switch back to "command window", enter `ntbc`, and hit Enter.

    This will display the available colors.
7. Enter `ntbc `, right-click, and pick Paste.

    The contents of the command prompt would look something like

    ```
    ntbc "C:\Games\Steam\steamapps\common\Nuclear Throne\data.win"
    ```
8. Add the desired arguments and hit Enter

    For example, if you wanted to change level 1-x' background to light blue, you could add ` c1=80A0FF` (colors are specified in hexadecimal format)

    Any colors not specified will be set to default Nuclear Throne colors (thus running the program without additional arguments will revert the `data.win` file to the original state).

    After hitting Enter, the program will display the progress, and update the file if there were any changes.

    Should the program display an error while saving the file, you may need to copy `data.win` file into a more accessible (non-Program-Files) location.

### Known issues ###

* Only works with Nuclear Throne update 98, because the file' position for seeking colors at is discovered via hex editing and hardcoded.

    Most likely will not work with mods that change the size of the file, but will tell you about it (to avoid corrupting the file).
* Cannot change shadow colors of some levels, because they are defaulted to black in code.