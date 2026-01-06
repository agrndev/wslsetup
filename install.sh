#!/bin/bash

set -euo pipefail

cat << "EOF"
     s                                                                                      .         s   
    :8      .uef^"                 .uef^"                                                  @88>      :8   
   .88    :d88E                  :d88E                     .u    .      ..    .     :      %8P      .88   
  :888ooo `888E            .u    `888E            .u     .d88B :@8c   .888: x888  x888.     .      :888ooo
-*8888888  888E .z8k    ud8888.   888E .z8k    ud8888.  ="8888f8888r ~`8888~'888X`?888f`  .@88u  -*8888888
  8888     888E~?888L :888'8888.  888E~?888L :888'8888.   4888>'88"    X888  888X '888>  ''888E`   8888   
  8888     888E  888E d888 '88%"  888E  888E d888 '88%"   4888> '      X888  888X '888>    888E    8888   
  8888     888E  888E 8888.+"     888E  888E 8888.+"      4888>        X888  888X '888>    888E    8888   
 .8888Lu=  888E  888E 8888L       888E  888E 8888L       .d888L .+     X888  888X '888>    888E   .8888Lu=
 ^%888*    888E  888E '8888c. .+  888E  888E '8888c. .+  ^"8888*"     "*88%""*88" '888!`   888&   ^%888*  
   'Y"    m888N= 888>  "88888%   m888N= 888>  "88888%       "Y"         `~    "    `"`     R888"    'Y"   
           `Y"   888     "YP'     `Y"   888     "YP'                                        ""            
                J88"                   J88"                                                               
                @%                     @%                                                                 
              :"                     :"                                                                   
EOF
sleep 2
echo 
echo "---------------------"
echo "Starting WSL setup..."
echo "---------------------"
sleep 1

echo "==> Create user..."
read -p "Enter username: " username
if ! id "$username" &>/dev/null; then
  useradd -m -G wheel $username
fi
while true; do
  if passwd "$username"; then
    break
  fi
done

echo 
echo "==> Updating system..."
echo 
pacman -Syu --noconfirm

echo 
echo "==> Installing sudo..."
echo 
pacman -Sy sudo --noconfirm

echo 
echo "==> Enabling wheel on sudoers file..."
sed -i 's/^# %wheel/%wheel/' /etc/sudoers

echo "==> Configuring WSL default user..."
cat > /etc/wsl.conf <<EOF
[boot]
systemd=true

[user]
default=$username
EOF

echo "==> Installing development tools..."
echo 
pacman -S --noconfirm \
  base-devel \
  devtools \
  make \
  git \
  github-cli \
  neovim \
  tmux

echo 
echo "==> Installing compilers and language toolchains..."
echo 
pacman -S --noconfirm \
  gcc \
  clang \
  python \
  python-pip \
  nodejs \
  npm \
  dotnet-sdk \
  dotnet-runtime \
  aspnet-runtime

echo 
echo "==> Installing containers and cache..."
echo 
pacman -S --noconfirm \
  docker \
  docker-compose \
  redis

echo
echo "==> Installing CLI & TUI tools..."
echo
pacman -S --noconfirm \
  yazi \
  lazygit \
  lazydocker

echo
echo "==> Installing browsers..."
echo
pacman -S --noconfirm \
  chromium \
  qutebrowser

echo
echo "==> Installing additional useful tools..."
echo
pacman -S --noconfirm \
  curl \
  wget \
  jq \
  ripgrep \
  fd \
  xdg-utils \
  fzf \
  bat \
  tldr

echo "==> Scheduling first_login.sh..."
cat > /home/$username/.bashrc <<'EOF'
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

bash <(curl -fsSL https://raw.githubusercontent.com/agrndev/wslsetup/refs/heads/main/first_login.sh)
EOF

echo "------------------------"
echo "Installation complete..."
echo "------------------------"
countdown=5
while [ "$countdown" -gt 0 ]; do
    echo "==> Logging in to $username in $countdown seconds..."
    ((countdown--))
    sleep 1
done

su - "$username"
