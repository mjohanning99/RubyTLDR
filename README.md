[![license][license-image]][license-url]

[license-url]: https://github.com/Jeytas/RubyTldr/blob/master/LICENSE.md
[license-image]: https://img.shields.io/github/license/Jeytas/RubyTldr.svg

# RubyTldr
## What is this?
Recently I discovered the 'tldr-pages' project and I found it very useful. The projects main idea is very simple – Providing scaled down man-pages that are easy to read, quick to understand and have the most importants commands easily visible with examples. The original tldr-pages is written in a variety of languages as far as I am able to tell. There is a Ruby port already available, however I wanted to create my own port of it to Ruby, mainly as as programming excersise. I am not basing my project on 'tldrb' however.

![screenshot](lib/media/screenshot.png)

## Installation and usage
### Installation
I tried keeping the installation process as easy and accessible as possible. I am still new to shell scripting, so errors might occur when installing the program. If you encounter an error, please file an Issue on this Repository.

__WARNING__: When you install RubyTldr using one of my installers, please be aware that it might potentially break other "tldr" installations you have installed on your computer. When you run the installer, an alias is added into your .bashrc file which might conflict with other pre-existing tldr installations.

To install Tldr you can simply run the following command:

`wget raw.githubusercontent.com/Jeytas/Installers/master/installer_tldr.sh ; bash installer_tldr.sh ; rm -rf installer_tldr.sh`

download the installer yourself and inspect it before running:

[Installer](https://raw.githubusercontent.com/Jeytas/Installers/master/installer_tldr.sh)

or just clone the repository and install it yourself.

__NOTE__: The installer requires you to have `git` and `wget` installed on your system and also requires your shell to be Bash.

### Usage
#### Preamble
After using one of the installers that I provided, please try and run `tldr --help`. If that command executes correctly, then you have successfully installed RubyTldr. In case the command cannot be found, please restart your current terminal and try again. Should that still not solve the problem, please open an Issue on this Github Repo.

#### Ruby version
I am using Ruby 2.4.2, so it's only officially supported on that version. However, I am very certain it will work on older versions of Ruby as well.

#### Gems (extensions) needed
In order for RubyTldr to correctly display the tldr-pages, you need to install a Ruby gem (which are the extensions of Ruby). This gem will provide colours and will colour the output of RubyTldr. Installing a gem can be done by typing `[sudo] gem install colorize` (Some systems / Ruby installations require the `sudo` and some don't). Afterwards, you will be ready to start RubyTldr with colours!

#### General usage
The usage of RubyTldr is as straightforward as the original tldr – Simply start the .rb file and append a command you wish to get more information on and RubyTldr will display it on your terminal in various colours.
There are also two flags you can use:
* `--help` will provide you with some help regarding the programming
* `--list` will list all the available commands

If you want to use `--list`, I would hightly recommend combining it with other Unix commands using the Unix pipeline as such: `tldr --list | sort | less`. This will sort the commands alphabetically and put them into a scrollable list. To search for a specific command you can use `grep` as such `tldr --list | grep -i "search_term_here"`

### Contributing
I welcome all contributions, be it actual code contributions, bug reports etc. If you want to make your own version of this program, you are free to do so. It is licensed under the GNU General Public license v3. If you wish to know exactly what you are and aren't allowed to do, please refer to the LICENSE document in this repository.
