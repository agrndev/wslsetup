#!/bin/bash

echo "------------------------------"
echo "Starting user configuration..."
echo "------------------------------"

echo "==> Configuring git..."
read -rp "Enter your git username: " git_username
read -rp "Enter your git email: " git_email
git config --global user.name $git_username
git config --global user.email $git_email
git config --global init.defaultBranch main

echo
echo "==> Github CLI authentication..."
read -p "Would you like to authenticate on Github? (y/n): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  gh auth login
else
  echo "Authentication skipped."
fi

echo
echo "==> Creating user directories..."
mkdir -p \
  $HOME/.config \
  $HOME/Documents \
  $HOME/Downloads \
  $HOME/repos

echo "==> Cloning dotfiles..."
git clone https://github.com/agrndev/dotfiles.git ~/.dotfiles
mkdir -p $HOME/.config
rm -f "$HOME/.bashrc"
cd ~/.dotfiles
stow bash nvim tmux
cd ~

echo "==> Configuring docker..."
sudo usermod -aG docker $USER
sudo systemctl enable --now docker.service

echo "------------------------------"
echo "User configuration complete..."
echo "------------------------------"

echo
echo "Restart your terminal."
