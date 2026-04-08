mv ~/.oh-my-zsh/.zshrc ~/.oh-my-zsh/.p10k.zsh ~/
apt-get update && apt-get upgrade
apt-get install -y zsh git vim unzip curl

# 安装C++相关工具
apt-get install -y cmake make
apt-get install -y clang clangd clang-format lldb
chsh -s $(which zsh)