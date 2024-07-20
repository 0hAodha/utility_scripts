# utility_scripts: a collection of miscellaneous scripts for use on my GNU/Linux laptop
 - `autopape.sh`: a simple script to endlessly loop through each image in a directory and set said image as the desktop wallpaper for a specified time period.
 Both the command used to set the wallpaper and the time interval between wallpaper changes can be specified with optional flags & arguments.
 Uses `feh --bg-fill` & an interval of `1m` by default.
 - `bluetooth-off.sh`: script for disabling bluetooth with bluetoothcl on a system that uses 
 runit as its init system (such as Void GNU/Linux).
 - `bluetooth-on.sh`: Same as `bluetooth-off.sh` but for enabling bluetooth.
 - `bluetooth_connect.pl`: Perl script that allows the user to select a bluetooth device to connect to via `dmenu`.
 - `bluetooth_info.pl`: Perl script to display information about connected bluetooth devices. Designed to be used with polybar.
 - `bspwm_window_count.sh`: script for listing the number of open windows on the current "desktop" (workspace) with the bspwm window manager.
 Primarily for use in status bars as indicator that windows may be hidden behind another when in floating or monocle mode.
 - `clean_files.sh`: script that loops through each file in a directory, opens each file with the `mimeopen` utility, and prompts the user to decide whether
 or not to delete the image.
 - `ensure_connected.sh`: script to remedy my broken WiFi, which has an issue of disconnecting unpredictably and then requiring several attempts to reconnect as 
 if the password supplied were incorrect despite it not being changed since the inital connection.
 This script checks if the WiFi is connected at regular intervals, and if not will keep trying to reconnect until successful.
 Reads WiFi network name from a `config.env` file and uses the hashed password already store by NetworkManager.
 - `file_previewer.sh`: a script for generating terminal file previews, for use in the terminal file manager `lf`.
 Uses the `mimetype` utility to identify the filetype and generates an appropriate preview (text, ASCII image, etc).
 - `hide_bar.sh`: script for hiding & unhiding the polybar bar on the bspwm window manager.
 - `hugo_post.sh`: simple script to create a new Hugo post with the directory structure `/content/posts/Post Title/index.md` instead of the default
 `/content/posts/Post Title.md` created when you run the command `hugo new content`.
 - `list_manual_pkgs.sh`: one-line script to list only the names of packages manually installed with the xbps package manager (the default Void package manager).
 - `qutebrowser_search.sh`: script that finds all the search engines defined in the qutebrowser `config.py` configuration file and makes them available for
 searching via dmenu, i.e. allow web searching with qutebrowser without having to wait for it to start up before you start your search.
 - `repos_checker.sh`: script to find all of the Git repositories in the current directory & its sub-directories and display each found repository's `git status`.
 - `screenshot.sh`: screenshot script with selection using `maim` that both saves the image file and adds the image to the `xclip` clipboard, and notifies the user
 of the screenshot via `notify-send`.
 - `stdin_to_notis.sh`: scripts that reads from `stdin` and sends each line as a system notification.
 Intended for use when a program that outputs to `stdout` is called from a non-terminal or graphical program, making the `stdout` output inaccessible.
 The output can instead be piped into this script to make it readable as a system notification.
 - `stopwatch.sh`: simple stopwatch script that counts the elapsed time in seconds, and displays it in the format HH:MM:SS.
 - `suicidal_script.sh`: a script that deletes itself. Doesn't do anything, just a proof of concept.
 - `sync_music.sh`: script to sync my Android phone's music library to the contents of my `~/media/music/` directory, i.e. copy my music library from my
 laptop to my phone.
 - `trippy.sh`: script that displays random visual data to the screen (only works when called from a TTY, by a user who has write access to the `fb0` device, e.g. `root`).
 - `webcam.sh`: one-line script that uses the video viewer program `mpv` as a webcam by using `/dev/video0` as its video file source.
