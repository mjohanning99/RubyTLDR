# TODO LIST
For an always up-to-date To-Do-list, please refer to this document.

## Finished items ##

- [x] Remove "commonlinux" directory and seperate it into *Linux* and *Common* directories and search accordingly. (Check if ARGV[0] exists in Linux, if not then search in Common).

- [x] Update all pages using the archive available at [tldr.sh/assets/tldr.zip](tldr.sh/assets/tldr.zip) and not using Github.

- [x] Perhaps create a seperate method just for parsing the .md documents.

- [x] Automatically download missing pages (perhaps with json file).

- [x] Remove "warning: calling URI.open via Kernel#open is deprecated, call URI.open".

- [x] Fix "invalid option: --update (OptionParser::InvalidOption" (running `tldr --update` results in this error).

- [x] Fix gem dependency errors (the method currently n use for installing missing gems virtually never works).

- [x] Fix "No such file or directory @ dir_initialize - /home/numitr0n/Documents/Programming/RubyTLDR/lib/pages/linux (Errno::ENOENT)" when no `pages` directory could be found -> Automatically check, inform the user and download the latest pages if that is the case.

## Items not yet finished / items being worked on ##

- [ ] Create a more user-friendly installation script (and, most importantly, one that does not run the command `rm -rf`!).

- [ ] The official tldr project now supports several languages besides English -> Try adding support for these.

- [ ] [still needs work] Add support for searching the commands of other operating systems (using an *--operating system* and *-os* flag) [Implemented in a different way. All commands for all operating systems are available without the need of adding an additional flag. The corresponding OS is listed at the top... still needs work, usage of -os flag might be better since there are several of the same commands for each operating system).

- [ ] The program thinks a page is available in the downloaded .json file even if it isn't -> do not use .include?(), but something more accurate.

- [ ] Add more verbose and colourful output (for things such as updating pages).

- [ ] Create two installers, one offline and one online.

- [ ] Create better Markdown parsing; perhaps a gem is available?

- [ ] Update --help flag
