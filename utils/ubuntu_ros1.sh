# 添加ROS软件源
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'

# 添加密钥
apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 2>/dev/null

# 安装ROS
apt-get update && apt-get install -y ros-noetic-desktop-full

# 设置环境变量
source /opt/ros/noetic/setup.zsh
echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc
source ~/.zshrc

# 安装rosinstall
apt-get update && apt-get install -y python3-rosinstall python3-rosinstall-generator python3-wstool