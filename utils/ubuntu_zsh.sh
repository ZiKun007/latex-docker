mv ~/.oh-my-zsh/.zshrc ~/.oh-my-zsh/.p10k.zsh ~/
apt-get update && apt-get upgrade
apt-get install -y zsh git vim wget tmux
chsh -s $(which zsh)