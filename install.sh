#!/bin/bash

# Install all the required packages that i use in my environment
set -e

cd ~/Downloads

install_curl() {
  sudo apt-get update
  sudo apt-get install curl
  echo "curl installed"
}

install_nvim() {
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  mv nvim.appimage ~/.local/bin/nvim
  echo "nvim installed"
}

install_python() {
  sudo apt-get install python3-pip
  echo "python installed"
}

install_go() {
  curl -LO https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
  echo "go installed"
}

install_aws() {
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  echo "aws installed"
}

install_docker() {
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  echo "running docker hello world"
  docker run hello-world
  echo "docker installed"
}

install_kubectl() {
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  kubectl version --client
  echo "kubectl installed"
}

install_helm() {
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  helm version
  echo "helm installed"
}

install_warp() {
  curl -LO "https://app.warp.dev/download?package=deb"
  sudo apt install ./warp*.deb
  echo "warp installed"
}

install_git() {
  sudo apt-get update
  sudo apt-get install git-all
  git version
  echo "git installed"
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  nvm --version
  echo "nvm installed"
}

install_oco() {
  npm install -g opencommit
  echo "oco installed"
}

install_lens() {
  curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null
  sudo apt update
  sudo apt install lens
  echo "lens installed"
}

install_kind() {
  [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
}

install_dbeaver() {
  curl -LO "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
  sudo dpkg -i ./dbeaver*.deb
  echo "dbeaver installed"
}

install_insomnia() {
  curl -LO "https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website"
  sudo dpkg -i ./insomnia*.deb
  echo "insomnia installed"
}

install_pritunl() {
  sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt jammy main
EOF

  sudo apt --assume-yes install gnupg
  gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
  gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A | sudo tee /etc/apt/trusted.gpg.d/pritunl.asc
  sudo apt update
  sudo apt install pritunl-client-electron
  echo "pritunl installed"
}

install_lazyvim() {
  rm -rf ~/.config/nvim
  mv nvim ~/.config/nvim
  echo "lazyvim installed"
}

install_bashrc() {
  rm ~/.bashrc
  mv bashrc ~/.bashrc
  echo "bashrc installed"
}

# run the functions
install_git
install_nvim
install_lazyvim
install_bashrc
install_python
install_aws
install_go
install_docker
install_kubectl
install_kind
install_helm
install_nvm
install_warp
install_oco
install_lens
install_dbeaver
install_insomnia
install_pritunl
