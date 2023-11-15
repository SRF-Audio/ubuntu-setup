#!/bin/bash

# ------------------------------------------------------------------------------
# Stephen's Fedora Setup Script
#
# To use, run: 
# wget "https://raw.githubusercontent.com/SRF-Audio/utility-scripts/main/fedora-setup.sh" -O setup.sh && chmod +x setup.sh && ./setup.sh
# ------------------------------------------------------------------------------

sudo dnf update -y

# Git
sudo dnf install git -y

# 1password
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install 1password

# VS Code
VS_CODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"
wget "$VS_CODE_URL" -O vscode.rpm
sudo dnf install ./vscode.rpm -y
rm ./vscode.rpm

# Slack
SLACK_URL="https://downloads.slack-edge.com/releases/linux/4.35.126/prod/x64/slack-4.35.126-0.1.el8.x86_64.rpm"
wget "$SLACK_URL" -O slack.rpm
sudo dnf install ./slack.rpm -y
rm ./slack.rpm

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" "" --unattended
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo yum groupinstall 'Development Tools'
brew install gcc

# zsh
sudo dnf install zsh
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo 'ZSH_THEME="agnoster"' >> ~/.zshrc
source ~/.zshrc
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# nerd-fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraMono/Regular/FiraMonoNerdFontMono-Regular.otf

# Brave
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser -y

# TigerVNC
sudo dnf install tigervnc -y
