#!/bin/bash -e
sudo apt-get update -y
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update -y
sudo apt-get install azure-cli -y


# install kubectl
curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl


# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# install kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv ~/kustomize /usr/local/bin

sudo apt install git curl wget nano -y

git config --global user.name "Larus Corp"
git config --global user.email admin@larus.com

sudo mkdir -p /home/manifest

git clone https://github.com/nelson2000/manifests_1.6v_stable.git /home/manifest

# docker
sudo apt-get update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-key fingerprint 0EBFCD88
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER 
sudo chmod 777 /var/run/docker.sock
sudo su - $USER
