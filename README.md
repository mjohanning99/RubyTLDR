[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](http://spacemacs.org)
[![license][license-image]][license-url]

[license-url]: https://github.com/Jeytas/RubyTldr/LICENSE.md
[license-image]: https://img.shields.io/github/license/Jeytas/RubyTldr.svg

# RubyTldr (rtldr)
Recently, I discovered the 'tldr-pages' project and I found it very useful. The project's main idea is very simple – Providing scaled down man-pages that are easy to read, quick to understand and have the most important commands easily visible with examples. The problem with most man-pages is that they are often written in a difficult to understand manner, they often contain way too much information and the information you're looking for might be buried on some pages later.
The original tldr-pages is written in a variety of languages as far as I am able to tell. There is a Ruby port already available, however I wanted to create my own port of it to Ruby, mainly as programming exercise. This project is not based on the already available 'tldrb'.

![screenshot](lib/media/screenshot.png)

## Installation
__NOTE__: The only operating system that is currently supported for installation is GNU/Linux and the program will not run if you are using a different operating system.

I tried keeping the installation process as easy and accessible as possible. I am still new to shell scripting, so errors might occur when installing the program. If you encounter an error, please file an Issue on this Repository.

### Automatic installation
__WARNING__: When you install RubyTldr using one of my installers, please be aware that it might potentially break other "tldr" installations you have installed on your computer. The installer will add a symlink of the "tldr" file to your computer's /bin folder and the symlink will be renamed to "rtldr"; this is done to decrease the likelihood of rtldr interfering with other, already existing tldr installations. It also means, however, that you will have to use the command "rtldr" instead of "tldr" to run RubyTldr.

The installer should take care of the majority of things, including the installation of the required gems (colorize and rubyzip); however, should rtldr complain about missing gems after running the installer, please refer to the Troubleshooting section down below.

__NOTE__: The installer requires you to have both `git` and `wget` installed on your system; it was tested on both Zsh and Bash, but should, in theory, be compatible with the majority of shells. Should you find that your shell breaks the installation, please file an issue on this project's Gitlab repository. Please refer to your distribution's documentation / manual in order to find out how to install both git and wget (a large amount of distrubitions have these two pre-installed).

To install RubyTldr you can simply run the following command:

`wget https://gitlab.com/mjohanning/RubyTldr/-/raw/master/installer.sh; bash installer_tldr.sh`

Should you want to inspect the source code of the downloader before running it, you can view it here:

[Installer](https://gitlab.com/mjohanning/RubyTldr/-/raw/master/installer.sh)

You can also simply download the `installer.sh` file from the repository and run it yourself.

### Manual installation
If you do not want to download any of my installers because you don't trust them or you simply want to download it yourself, you can do so very easily. Simply download this repository (there's a green button at the top that allows you to do so) and extract it. When you open the folder you extracted it into, you will see the same files as on this repository. If you want to start RubyTldr, you will need to open the file named "tldr" (with no file ending), comment the line saying you want to load RubyTldr from the .rtldr folder and uncomment the line saying that you want to load from the local folder. You can then simply run RubyTldr by typing ./tldr when inside the same directory.

## Usage
### Preamble
After using one of the installers that I provided, please try and run `rtldr --help`. If that command executes correctly, then you have successfully installed RubyTldr. In case the command cannot be found, please restart your current terminal and try again. Should that still not solve the problem, please open an Issue on this Gitlab Repo.

### Ruby version
I am using Ruby 2.7.0, so it's only officially supported on that version. However, I am very certain it will work on older or newer versions of Ruby as well. I also recommend using [rvm](https://rvm.io) for managing different Ruby installations.

### General usage
The usage of RubyTldr is as straightforward as the original tldr – Simply type "rtldr" and append a command you wish to get more information on and RubyTldr will display it on your terminal in various colours (if you type rtldr tar the information you can see on the picture at the top of this Readme will be displayed).
There are also three flags you can use:
* `--help` will provide you with some help regarding the programming
* `--list` will list all the available commands
* `--update` will update the page database 

If you want to use `--list`, I would highly recommend combining it with other Unix commands using the Unix pipeline as such: `rtldr --list | sort | less`. This will sort the commands alphabetically and put them into a scroll-able list. To search for a specific command you can use `grep` as such `rtldr --list | grep -i "search_term_here"`

The words displayed in `<>` are to be replaced by the user according to their needs. For example, in the `rtldr tar`, the following means `tar xf replace_this_string_with_your_desired_tar_file -C replace_this_string_with_the_folder_you_want_to_extract_the_tar_to` : `tar xf <source.tar> -C <folder>`. The `<>` do not need to be written into the command, they just signify that it should be replaced according to what the user wants to use the command on.

### Tldr pages for other operating systems
You are able to access all the tldr pages from whatever operating system. The operating system the command is intended to be used on is the first thing on the Tldr page, written in all capital letters.

### New tldr pages
The original tldr project is alive and well. New pages are being added regularly and old ones are being updated. In order to keep up with all the changes, I implemented a feature that will automatically try to download commands that weren't found on your machine. If it is able to find the responding tldr-page on the official Gitlab Repository, it will download it and you will be able to use it locally as well.

![New pages download](lib/media/newpages.png)

If you wish to update your database manually, you can do so with the aforementioned `--update` flag. 

## Troubleshooting
### Program doesn't start
#### Wrong operating system
The main culprit for this will be that you are using the wrong operating system. If you are using Windows or Mac or anything other than Linux-based operating systems, the program will refuse to run. You can remove the code that checks for the operating system in the `tldr.rb` file located in `lib/bin`. However, I can not assure you that RubyTldr will work then.

#### Gems not installed
RubyTldr relies on two extensions of the Ruby programming language, so-called gems. These gems are `colorize` and `rubyzip`. `colorize` will format the output and colorize it so that it looks more appealing and `rubyzip` will extract the .zip file that contains the pages. You need to have both of these gems installed for the program to run. Generally, the program checks if the needed gems are installed on your system and install them if needed. However, that might fail. In that case, please try and install the gems manually. Ruby gems are generally installed by either typing `gem install gem_name` or `sudo gem install gem_name`.

## TODO
Please refer to the TODO.md document located in this repository for an always updated TODO-list. However, there are still a few things in general that I need to restructure and improve, most of which won't directly impact the user experience. One important feature that I haven't added yet is being able to look at the tldr pages of a specific operating system which is available on the original tldr-pages project. Also, I often add `#TODO` comments to my code, so you might find more information in the source code as well.

## Contributing
I welcome all contributions, be it actual code contributions, bug reports etc. If you want to make your own version of this program, you are free to do so. It is licensed under the GNU General Public License Version 3 (GPLv3). It's one of the most popular free software license and it allows the users to do virtually anything with the software. But before you do, and you wish to know exactly what you are and aren't allowed to do, please refer to the LICENSE document in this repository.

__Please do not add new tldr pages to this Gitlab repository__

If you wish to create your own tldr pages (as in the actual explanation pages), then I would highly encourage you to do so on the original Github repository which is simply called [tldr](https://github.com/tldr-pages/tldr).
