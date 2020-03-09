[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)
[![license][license-image]][license-url]

[license-url]: https://github.com/Jeytas/RubyTldr/LICENSE.md
[license-image]: https://img.shields.io/github/license/Jeytas/RubyTldr.svg

# RubyTldr (rtldr)
![screenshot](lib/media/screenshot.png)

Recently, I discovered the 'tldr-pages' project and I found it very useful. The project's main idea is very simple – Providing scaled down man-pages that are easy to read, quick to understand and have the most important commands easily visible with examples. The problem with most man-pages is that they are often written in a difficult to understand manner, they often contain way too much information and the information you're looking for might be buried on some pages later.
There are a large amount of tldr-pages clients written in a variety of different programming languages; a Ruby port, too, is already available. This port has, however, not been maintained in quite a while. Additionally, I wanted to create my own Ruby port as a programming exercise.

## Installation
There are a number of ways of installing RubyTldr.

__NOTE__: The only operating system that is currently supported for installation is GNU/Linux and the program will not run if you are using a different operating system.

### Prerequisites

#### Root access
First and foremost, installing RubyTldr or any of its prerequisites virtually always requires you to have root access. This means that you need to either ask your administrator for a root password or ask them to install it for you instead if you do not have root access on your machine.
If you own your computer yourself (and are not using a public computer — such as at school or at the library — or sharing it with others in the same household), you will most likely have root acccess; in that case, just have your password ready, as you will need to enter it at various stages of installing RubyTldr and its prerequisites.

#### Ruby version
The most important prerequisite for installing RubyTldr is, obviously, a working Ruby installation. I am using Ruby 2.7.0, so it's only officially supported on that version. However, I am quite certain it will work on older or newer versions of Ruby as well. I also recommend using [rvm](https://rvm.io) for managing different Ruby installations. Please refer to your distribution's documentation / manual on how to install packages and check [Ruby's official](https://www.ruby-lang.org/en/downloads/) website on how to install it on a variety of different GNU/Linux distributions. It is generally an easy and fast process.

#### Ruby gems
The required Ruby gems (`colorize` and `rubyzip`) should be installed automatically when using one of my installers. When installing manually or when encountering errors (RubyTldr complaining about missing gems), please refer to the Troubleshooting section at the bottom of this README.

### Automatic installation
The easiest way of installing RubyTldr is to simply use one of my installers. You can either download the `installer.sh` file and let it handle everything or clone the repository and download the pages yourself for installing it on a machine with no internet access.

I tried keeping the installation process as easy and accessible as possible. I am still new to shell scripting, so errors might occur when installing the program. If you encounter an error, please file an issue on this repository.

__WARNING__: When you install RubyTldr using one of my installers, please be aware that it might potentially break other "tldr" installations you have installed on your computer. The installer will add a symlink of the "tldr" file to your computer's /bin folder and the symlink will be renamed to "rtldr"; this is done to decrease the likelihood of rtldr interfering with other, already existing tldr installations. It also means, however, that you will have to use the command "rtldr" instead of "tldr" to run RubyTldr.

The installer should take care of the majority of things, including the installation of the required gems (colorize and rubyzip) and the creation of a symlink in the /bin folder (so that you can access rtldr from anywhere, not just from the downloaded directory); however, should rtldr complain about missing gems after running the installer (or not run at all), please refer to the Troubleshooting section down below.

__NOTE__: The installer requires you to have both `git` and `wget` installed on your system; it was tested on both Zsh and Bash, but should, in theory, be compatible with the majority of shells. Should you find that your shell breaks the installation, please file an issue on this project's Gitlab repository. Please refer to your distribution's documentation / manual in order to find out how to install both git and wget (a large amount of distrubitions have these two pre-installed). If you do not have either of these installed and are not willing to do so, please read the section on the automatic offline installation down below.

__NOTE__: There is an optional flag `-q` (`./installer.sh -q`) that can be used if you wish to skip the questions and answer everything the installer thinks is necessary with 'yes' by default. I would generally not recommend this, but is it rather handy, I believe, for when you wish to upgrade to a newer version and already know what the installer is going to be doing.

### Online
To install RubyTldr on a machine that has an active Internet connection, you can simply run the following command:

`wget https://gitlab.com/mjohanning/RubyTldr/-/raw/master/installer.sh ; bash installer.sh`

This command will download (using `wget`) the `installer.sh` file from this repository and execute it (using `bash`).
Should you want to inspect the source code of the downloader before running it, you can view it here: [Installer](https://gitlab.com/mjohanning/RubyTldr/-/raw/master/installer.sh)

#### Offline
If you wish, you are also able to download the repository — which is usually done in the form of a .zip archive —, extract it, enter the folder and run the `installer.sh` file. This is a good option if you wish to install RubyTldr on a machine that does not have `git` and `wget` installed. The installer will recognise that you have the required files on your machine and will not try to download them using `git`.
Running the installer is very simple; you merely need to open a terminal window, move into the directory that was extracted (usually called "RubyTldr") using `cd` (`cd RubyTldr`) and run either `bash installer.sh` or `./installer.sh`. On some GNU/Linux distributions' graphical file managers it may also be possible to simply double-click the installer.
If the machine you are trying to install RubyTldr onto does not have any access to the Internet whatsoever, you will also need to download a copy of the original tldr pages. To do so, first install RubyTldr as described above, then download a copy of the pages by clicking the following link: https://tldr.sh/assets/tldr.zip. The contents of the .zip file have to be extracted into the lib/ folder of your RubyTldr installation, which can be found at `~/.rtldr` (Thus, the directory you will need to put the contents of the .zip file into will be `~/.rtldr/lib`). If you are using a graphical file manager instead of the terminal, you may have to enable it to display hidden directories (directories beginning with a full-stop are hidden by default). This can be enabled by pressing `CTRL+H` on a large amount of file managers; however, should this not work, please check the documentation of your file manager to find out how to enable it to display hidden files and directories.

### Manual installation
If you would rather install it yourself, you can do that quite easily too! Here, too, you can have two options, one that requires an active Internet connection and one that does not.

#### Online
If you do not want to download any of my installers because you don't trust them or you simply want to download it yourself, you can do so very easily. Simply download this repository (there's a green button at the top that allows you to do so) and extract it. When you open the folder you extracted it into, you will see the same files as on this repository. If you want to start RubyTldr, you will need to open the file named "tldr" (with no file ending) with your preferred text editor, comment the line (place a `#` in front of it) saying you want to load RubyTldr from the .rtldr folder and uncomment the line (remove the `#` in front of it) saying that you want to load from the local folder. You can then simply run RubyTldr by typing ./tldr when inside the same directory.

You could also simply run the `tldr.rb` file located in the lib/bin/ directory by typing `./lib/bin/tldr.rb` or `ruby lib/bin/tldr.rb` whilst inside the downloaded directory.

#### Offline
As described in the section on the automatic installation, you will need to download a copy of the original tldr pages if the machine you are installing RubyTldr onto does not have any Internet access. Unlike the automatic installation, however, you will need to extract them into the downloaded folder's `lib` directory (such as `~/Downloads/RubyTldr/lib`) and not into `~/.rtldr/lib`.

### Updating to a new version
Frequently, a new version of RubyTldr is released and should you wish to update to this new version, you can do so with ease using the installer. You simply have to run the installer once a new version has been released, and it will automatically detect a previously installed RubyTldr version, inform you of its existence and give you the option to replace it.

## Usage
### Preamble
After using one of the installers that I provided, please try and run `rtldr --help`. If that command executes correctly, then you have successfully installed RubyTldr. It should display some help and, if you used any of the online installing methods, it will download the latest version of the tldr pages.
In case the command cannot be found, please restart your current terminal and try again. Should that still not solve the problem, please open an Issue on this Gitlab Repo.


### General usage
The usage of RubyTldr is as straightforward as the original tldr – Simply type "rtldr" and append a command you wish to get more information on and RubyTldr will display it in your terminal window in various colours (if you type `rtldr tar` the information you can see on the picture at the top of this Readme will be displayed).
There are also three flags you can use:
* `--help` will provide you with some help regarding the programming
* `--list` will list all the available commands
* `--update` will update the page database

If you want to use `--list`, I would highly recommend combining it with other Unix commands using the Unix pipeline as such: `rtldr --list | sort | less`. This will sort the commands alphabetically and put them into a scroll-able list. To search for a specific command you can use `grep` as such `rtldr --list | grep -i "search_term_here"`

The words displayed in `<>` are to be replaced by the user according to their needs. For example, in the `rtldr tar`, the following means `tar xf replace_this_string_with_your_desired_tar_file -C replace_this_string_with_the_folder_you_want_to_extract_the_tar_to` : `tar xf <source.tar> -C <folder>`. The `<>` do not need to be written into the command, they just signify that it should be replaced according to what the user wants to use the command on.

### Tldr pages for other operating systems
You are able to access all the tldr pages from whatever operating system. The operating system the command is intended to be used on is the first thing on the Tldr page, written in all capital letters.
RubyTLDR will automatically jump to a different operating system if the command entered could not be found on the operating system you are currently using (which, for the most part, will probably be GNU/Linux). If you instead wish to show you the information of a command available on several operating systems (such as `mkdir`) on one specific OS, you can specify the platform with the `--platform` or `-p` flag as follows: `rtldr --platform windows mkdir`; this will show you the `mkdir` information specifically for Windows.

### New tldr pages
The original tldr project is alive and well. New pages are being added regularly and old ones are being updated. In order to keep up with all the changes, I implemented a feature that will automatically try to download commands that weren't found on your machine. If it is able to find the corresponding tldr-page on the official Gitlab Repository, it will download it and you will be able to use it locally as well.

![New pages download](lib/media/newpages.png)

If you accidently deleted a command from the `pages` folder or if you simply want to update the page cache to get the latest version of all the pages, you can simply run rtldr with the aforementioned `--update` flag as follows `rtldr --update`. This will remove the current page cache and replace it with the most up-to-date one.

## Troubleshooting
You might encounter an error or two when installing RubyTldr. The majority of errors should be dealt with by the automatic installer or even rtldr itself. If, however, you are using one of the manual methods, you may encounter an error that you did not understand. In this section you will find out how to deal with the majority of errors that I can think of happening.
Should your error not be listed herein or should your error not be fixable using the information presented down below, please file an issue on this repostitory. You may also send me an email to info[at]marvinjohanning[dot]de (wherein [at] has to be replaced by `@` and [dot] by `.`) if you are unable to create an issue.

### Program doesn't start
#### Wrong operating system
The main culprit for this will be that you are using the wrong operating system. If you are using Windows or Mac or anything other than Linux-based operating systems, the program will refuse to run. You can remove the code that checks for the operating system in the `tldr.rb` file located in `lib/bin`. However, I can not assure you that RubyTldr will work then.

#### Gems not installed
RubyTldr relies on two extensions of the Ruby programming language, so-called gems. These gems are `colorize` and `rubyzip`. `colorize` will format the output and colorize it so that it looks more appealing and `rubyzip` will extract the .zip file that contains the pages. You need to have both of these gems installed for the program to run. Generally, the program checks if the needed gems are installed on your system and install them if needed. However, that might fail. In that case, please try and install the gems manually. Ruby gems are generally installed by either typing `gem install gem_name` or `sudo gem install gem_name`.

#### Symlink not set correctly
It is possible that the symlink could not be created successfully. You can check by running the command `whereis rtldr` or by simply searching the /bin directory with `find /bin/* -name rtldr`; this should show you the location of the executable rtldr symlink. If nothing was found, please create a symlink manually by typing `sudo ln -s ~/.rtldr/tldr /bin/rtldr`.

#### Wrong Ruby version
As stated further at the top of this README, the only supported Ruby version is the one I am currently using (as that is the only one I will be doing extensive testing on). While I believe that the majority of Ruby versions should be compatible with it, this is not absolutely certain. Older versions of Ruby may have trouble with the current gem versions or certain native Ruby commands. I would always recommend installing the latest version of Ruby unless you have a good reason not to, as newer versions also frequently fix a lot of security issues. Should you require an older Ruby version, you can use the aforementioned rvm (Ruby Version Manager) to manage several Ruby installations.

## Contributing
I welcome all contributions, be it actual code contributions, bug reports etc. If you want to make your own version of this program, you are free to do so. It is licensed under the GNU General Public License Version 3 (GPLv3). It's one of the most popular free software license and it allows the users to do virtually anything with the software. But before you do, and you wish to know exactly what you are and aren't allowed to do, please refer to the LICENSE document in this repository.

__Please do not add new tldr pages to this Gitlab repository__

If you wish to create your own tldr pages (as in the actual explanation pages), then I would highly encourage you to do so on the original Github repository which is simply called [tldr](https://github.com/tldr-pages/tldr).
