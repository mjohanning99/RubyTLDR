##!/bin/bash

#Method for catching errors
error_catch() {
  echo "$1" 1>&2
  exit 1
}

#Variable that stores the ruby version installed on the computer
ruby_version=$(ruby -v)

#Informing the user about their current Ruby installation / Informing them of a missing Ruby installation and exiting the installer.
if [[ $ruby_version == *ruby* ]]; then printf "A Ruby installation ($ruby_version) has been found on your machine. Proceeding ... \n\n"; else "No Ruby installation could be found on your machine. Please download the latest version of Ruby using your distribution's package manager or by compiling it from source"; exit; fi

#Check if the default installation directory (~/.rtldr) already exists, inform the user and give them the choice of having it deleted.
if [ -e ~/.rtldr ]
then
  echo "The program seems to have already been installed previously, since the ~/.rtldr folder already exists. Do you wish to remove the folder and replace the old RubyTldr version with the one you have just downloaded?"

    select yn in "Yes" "No"; do
        case $yn in
            Yes ) echo "Removing old ~/.rtldr... " ; rm -r --interactive=never ~/.rtldr ; break;;
            No ) echo "The old ~/.rtldr directory will not be removed, installation cannot carry on. Aborting." ; exit; break;;
        esac
    done
  else
    echo "Installation starting ..."
fi

#Check whether or not the tldr executable and the tldr.rb file exist and if they do, do not download a new
if [[ -e tldr && -e lib/bin/tldr.rb ]]
then
    echo "You seem to have already downloaded the entire repository. Skipping the download ..."
    echo "Creating ~/.rtldr ..."
    if mkdir ~/.rtldr; then
      echo "Creating ~/.rtldr was successful."
    else
      echo "Could not create ~/.rtldr! Aborting!"
    fi

    echo "Coyping contents of $(pwd) into ~/.rtldr ..."
    if cp -r . ~/.rtldr; then
      echo "Copying successful."
    else
      echo "Could not copy contents from $(pwd) to ~/.rtldr! Aborting!"
    fi

    printf "\n"
fi

if [ -L /bin/rtldr ]
then
    echo "It seems like this program has already been installed previously, since there already exists a symlink called 'rtldr' within the /bin folder. It is recommended to delete this file as it may point to an incorrect location and could thus potentially destroy your rtldr installation."

    echo "Would you like the installer to delete the symbolic link? [1 = Yes, 2 = No]"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) sudo rm /bin/rtldr; break;;
            No ) echo "The symbolic link will not be removed. Please be aware that this may break your rtldr installation. Setting a symlink manually, instead, and potentially altering a few of the files will now be necessary."; break;;
        esac
    done
fi

if [[ `gem list` != *colorize* ]]
then
    echo "The gem (extension) called 'colorize' could not be found in your local Ruby installation. It is, however, required in order to be able to run rtldr. Do you wish to let the installer try to install it for you? [1 = Yes, 2 = No]"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) gem install colorize; break;;
            No ) echo "The colorize gem will not be installed automatically. Please install it manually."; break;;
        esac
    done
fi

if [[ `gem list` != *rubyzip* ]]
then
    echo "The gem (extension) called 'rubyzip' could not be found in your local Ruby installation. It is, however, required in order to be able to run rtldr. Do you wish to let the installer try to install it for you? [1 = Yes, 2 = No]"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) gem install rubyzip; break;;
            No ) echo "The rubyzip gem will not be installed automatically. Please install it manually."; break;;
        esac
    done
fi

if [[ ! -e tldr && ! -e lib/bin/tldr.rb ]]
then
  echo "Cloning from repository starting."
  git clone https://gitlab.com/mjohanning/RubyTldr.git ~/.rtldr

  if [ $? == 0 ]; then echo "Cloning successful."; else echo "Cloning failed. Please check your internet connection and verify that you have 'git' installed on your machine." && exit; fi
fi

echo "Creating symlink of ~/.rtldr in /bin."
if [ -L /bin/rtldr ]; then echo "Symlink exists, not creating a new one."; else sudo ln -s ~/.rtldr/tldr /bin/rtldr; fi

echo "Removing installer ..."
sudo rm installer.sh

echo "If you see this message, everything should've been installed correctly. To ensure that it has, please run 'rtldr tldr'. If you get an explanation of this program, then everything worked correctly."
