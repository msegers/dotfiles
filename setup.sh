#!/bin/bash
set -e

# TODO: make laptop variant

# Update mirrors
sudo pacman -Syu
# Install shit from package_list.txt
sudo pacman -S `cat ~/.config/package_list.txt` --needed

# enable bluetooth always 
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# install yay and create projects folder if the folder isn't there yet
if [ ! -d "$HOME/projects" ]; then
  mkdir "$HOME/projects"
  cd "$HOME/projects"
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  sudo pacman -S base-devel
  makepkg -si
fi

# don't ask questions
yay --save --answerdiff None --answerclean None --removemake

# install AUR packages
yay -S `cat ~/.config/yay_package_list.txt` --needed

if grep -Fxq "source ~/.config/bash-extend" ~/.bashrc
then
  echo 'bash extend already sourced';
else 
  sed -i '/^PS1=/d' "$HOME/.bashrc"
  echo "source ~/.config/bash-extend" >> ~/.bashrc 
  # load the actual config in this term
  . ~/.config/bash-extend
fi

# checkout nvim
cd ~/.config
git submodule init
git submodule update
git config --global push.autoSetupRemote 1

