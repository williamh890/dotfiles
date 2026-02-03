sudo apt update -y
sudo apt install build-essential -y
sudo apt install git curl wget tmux nfs-common -y

git clone https://github.com/awslabs/git-secrets.git
cd git-secrets
sudo make install

# Python
sudo apt install python3-dev python3-pip python3-venv -y

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install node

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

sudo ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim # for sudo nvim
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim

# Mamba
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge4-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh

# Docker
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# vscode
sudo snap install code --classic

# Copy Config files
# - cp .bashrc
# - cp .tmux.conf
# - cp .gitconfig

# Install qgis https://qgis.org/resources/installation-guide/#debian--ubuntu
# sudo apt install gnupg software-properties-common
#

# Setup github ssh key
# https://chatgpt.com/s/t_69813989bc6c8191af8ec42d1b819140

 # Optional: remap caps lock to escape (somehow, xremap, gnome-tweaks???)
