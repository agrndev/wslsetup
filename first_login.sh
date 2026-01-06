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
mkdir -p $HOME/.config
git clone https://github.com/agrndev/nvim.git $HOME/.config/nvim
git clone https://github.com/agrndev/tmux.git $HOME/.config/tmux

echo "==> Configuring .bashrc..."
cat > $HOME/.bashrc <<'EOF'
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export BROWSER="chromium"
export EDITOR="nvim"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias new-session='$HOME/.config/tmux/new-session.sh'
alias load-session='$HOME/.config/tmux/load-session.sh'

PS1='\[\e[0m\]\u\[\e[0;2m\]@\[\e[0m\]\h \[\e[0m\](\[\e[0m\]\W\[\e[0m\]) \[\e[0;1m\]> \[\e[0m\]'

if command -v tmux >/dev/null 2>&1 && [[ -z "$TMUX" ]]; then
  tmux attach -t main 2>/dev/null || tmux new -s main
fi
EOF

echo "==> Configuring docker..."
sudo usermod -aG docker $USER
sudo systemctl enable --now docker.service

echo "------------------------------"
echo "User configuration complete..."
echo "------------------------------"

