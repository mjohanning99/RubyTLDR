#!/bin/bash
#TODO: Change output for -q flag (text very crammed)

#Method for catching errors
error_catch() {
  echo "$1" 1>&2
  exit 1
}

#Variable that stores the ruby version installed on the computer
ruby_version=$(ruby -v)

#Variable that contains current supported Ruby version
supported_ruby="2.7.0"

while getopts ":q" opt; do
  case ${opt} in
    q )
      no_questions=true
    ;;
  esac
done

#Informing the user about their current Ruby installation / Informing them of a missing Ruby installation and exiting the installer.
if [[ $ruby_version == *ruby* ]]; then printf "A Ruby installation ($ruby_version) has been found on your machine. Proceeding ... \n\n"; else "No Ruby installation could be found on your machine. Please download the latest version of Ruby using your distribution's package manager or by compiling it from source"; exit; fi

#Informing the user about a his Ruby version if it is not the same as the supported Ruby version
if [[ ! $ruby_version =~ $supported_ruby ]]; then
  while true; do
    read -r -p "You are not running the recommended Ruby Version $supported_ruby your machine; this may lead to unintended side-effects and can make the program unsuable! Are you sure you want to continue? [y/n] " input

  case $input in
    [yY][eE][sS]|[yY])
      echo "Continuing with installation..."
      break
      ;;
    [nN][oO]|[nN])
      echo "Aborting installation!"
      exit
      ;;
    *)
      echo "Invalid input. Please enter 'Y' or 'N'"
      ;;
    esac
  done
fi

#Check if the default installation directory (~/.rtldr) already exists, inform the user and give them the choice of having it deleted.
if [[ -e ~/.rtldr ]]; then
  if [ ! $no_questions ]; then
    while true; do
      read -r -p "The program seems to have already been installed previously, since the ~/.rtldr folder already exists? Do you wish to remove the folder and replace the old RubyTldr version with the one you have just downloaded? [y/n] " input

      case $input in
        [yY][eE][sS]|[yY])
          echo "Removing old ~/.rtldr... "
          if rm -r --interactive=never ~/.rtldr; then
            echo "Successfully removed ~/.rtldr folder. Continuing with installation ..."
          else
            error_catch "Unable to remove folder, aborting!"
          fi
          break
          ;;
        [nN][oO]|[nN])
          echo "Folder will not be removed, aborting installation."
          exit
          ;;
        *)
          echo "Invalid input. Please enter 'Y' or 'N'"
          ;;
        esac
      done
    else
      echo "Removing old ~/.rtldr... "
      if rm -r --interactive=never ~/.rtldr; then
        echo "Successfully removed ~/.rtldr folder. Continuing with installation ..."
      else
        error_catch "Unable to remove folder, aborting!"
      fi
    fi
else
  echo "Installation starting"
fi

#Check whether or not the tldr executable and the tldr.rb file exist and if they do, do not download a new
if [[ -e tldr && -e lib/bin/tldr.rb ]]; then
  echo "You seem to have already downloaded the entire repository. Skipping the download ..."
  echo "Creating ~/.rtldr ..."
  if mkdir ~/.rtldr; then
    echo "Creating ~/.rtldr was successful."
  else
    error_catch "Could not create ~/.rtldr! Aborting!"
  fi

  printf "\n"

  echo "Coyping contents of $(pwd) into ~/.rtldr ..."
  if cp -r . ~/.rtldr; then
    echo "Copying successful."
  else
    error_catch "Could not copy contents from $(pwd) to ~/.rtldr! Aborting!"
  fi
  printf "\n"
fi

if [ -L /bin/rtldr ]; then
  if [ ! $no_questions ]; then
    while true; do
      read -r -p "It seems like this program has already been installed previously, since there already exists a symlink called 'rtldr' within the /bin folder. It is recommended to delete this file as it may point to an incorrect location and could thus potentially destroy your rtldr installation. Would you like the installer to delete the symbolic link? [y/n] " input

      case $input in
        [yY][eE][sS]|[yY])
          echo "Removing symlink from /bin folder."
          if sudo rm /bin/rtldr; then
            echo "Successfully removed symlink. Continuing with installation ..."
          else
            error_catch "Unable to remove symlink, aborting!"
          fi
          break
          ;;
        [nN][oO]|[nN])
          echo "Symlink will not be removed automatically. Please be aware that this may break your installation. Setting a symlink manually, instead, and potentially altering a few of the files will now be necessary"
          break
          ;;
        *)
          echo "Invalid input. Please enter 'Y' or 'N'"
          ;;
        esac
    done
  else
    if sudo rm /bin/rtldr; then
      echo "Successfully removed symlink. Continuing with installation ..."
    else
      error_catch "Unable to remove symlink, aborting!"
    fi
  fi
  printf "\n"
fi

if [[ `gem list` != *colorize* ]]; then
  if [ ! $no_questions ]; then
    while true; do
      read -r -p "The gem (extension) called 'colorize' could not be found in your local Ruby installation. It is, however, required in order to be able to run rtldr. Do you wish to let the installer try to install it for you? [y/n] " input

      case $input in
        [yY][eE][sS]|[yY])
          echo "Installing colorize gem ..."
          if gem install colorize; then
            echo "Successfully installed colorize gem."
          else
            error_catch "Unable to install the gem, aborting!"
          fi
          break
          ;;
        [nN][oO]|[nN])
          echo "The colorize gem will not be installed automatically. Please install it manually."
          break
          ;;
        *)
          echo "Invalid input. Please enter 'Y' or 'N'"
          ;;
        esac
    done
  else
    echo "Installing colorize gem ..."
    if gem install colorize; then
      echo "Successfully installed colorize gem."
    else
      error_catch "Unable to install the gem, aborting!"
    fi
  fi
  printf "\n"
fi

if [[ `gem list` != *rubyzip* ]]; then
  if [ ! $no_questions ]; then
    while true; do
      read -r -p "The gem (extension) called 'rubyzip' could not be found in your local Ruby installation. It is, however, required in order to be able to run rtldr. Do you wish to let the installer try to install it for you? [y/n] " input

      case $input in
        [yY][eE][sS]|[yY])
          echo "Installing 'rubyzip' gem ..."
          if gem install rubyzip; then
            echo "Successfully installed 'rubyzip' gem."
          else
            error_catch "Unable to install the gem, aborting!"
          fi
          break
          ;;
        [nN][oO]|[nN])
          echo "The 'rubyzip' gem will not be installed automatically. Please install it manually."
          break
          ;;
        *)
          echo "Invalid input. Please enter 'Y' or 'N'"
          ;;
      esac
    done
  else
    echo "Installing 'rubyzip' gem ..."
    if gem install rubyzip; then
      echo "Successfully installed 'rubyzip' gem."
    else
      error_catch "Unable to install the gem, aborting!"
    fi
  fi
  printf "\n"
fi

if [[ ! -e tldr && ! -e lib/bin/tldr.rb ]]; then
  echo "Cloning from repository starting."
  git clone https://gitlab.com/mjohanning/RubyTldr.git ~/.rtldr

  if [ $? == 0 ]; then echo "Cloning successful."; else echo "Cloning failed. Please check your internet connection and verify that you have 'git' installed on your machine." && exit; fi

  printf "\n"
fi

echo "Creating symlink of ~/.rtldr in /bin."
if [ -L /bin/rtldr ]; then echo "Symlink exists, not creating a new one."; else sudo ln -s ~/.rtldr/tldr /bin/rtldr; fi

printf "\n Downloading the latest TLDR pages. This may take a while depending on your internet speed ..."
/bin/rtldr --update

echo "If you see this message, everything should've been installed correctly. To ensure that it has, please run 'rtldr tldr'. If you get an explanation of this program, then everything worked correctly."

if [[ -e installer.sh ]]; then
	echo "Removing installer ..."
	sudo rm installer.sh
fi
