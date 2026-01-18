## WSL2 Development Environment

### About
This is my **WSL2 Development Environment** installer.

### Instructions
1. Go to the Microsoft Store and install the `Windows Terminal` application;
2. Also on Microsoft Store, install the `WSL (Windows Subsystem for Linux)` application;
3. To [install Arch Linux distro](https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL): \
  3.1. Enable virtualization on UEFI SETUP \
  3.2. [Powershell] Update WSL by running `wsl --update` command \
  3.3. [Powershell] Install Arch Linux distro by running `wsl --install archlinux` command
4. On WSL, run the following command `bash <(curl -fsSL https://raw.githubusercontent.com/agrndev/wslsetup/refs/heads/main/install.sh)`

### Details
Some of the available functionalities are:
* Manage files
* Edit code
* Debug code 
* Compile code
* Send HTTP requests
* Manage Databases
* Manage Cache
* Manage Docker containers
* Visualize markdown documents
* Interact with Github repositories

Code editor: `Neovim`.

Supported programming languages:
* C# (.NET)
* C/CPP
* Go
* JavaScript
* Typescript
* HTML/CSS
* Markdown
* Python
* Bash
* HTTP
* Dockerfile
* JSON
* YAML

Compilers:
* GCC
* Clang
* Go

Programs:
* dotnet-sdk
* dotnet-runtime
* aspnet-runtime
* go
* nodejs
* python
* git
* gh
* make
* npm
* pip
* docker
* docker-compose
* redis
* chromium
* qutebrowser
* tmux
* yazi
* lazyGit
* lazyDocker
* fzf
* bat
* tldr
