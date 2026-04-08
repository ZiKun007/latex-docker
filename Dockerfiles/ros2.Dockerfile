# ===== Base & ROS Distro =====
ARG ROS_DISTRO=humble
FROM tiryoh/ros2-desktop-vnc:${ROS_DISTRO}

# ===== APT / locale =====
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# ===== root 环境 =====
USER root
WORKDIR /root

# 可选：你的个性化文件（若没有就删/注释这些行）
COPY .oh-my-zsh /home/ubuntu/.oh-my-zsh
COPY config/.zshrc /home/ubuntu/.zshrc
COPY config/.p10k.zsh /home/ubuntu/.p10k.zsh
COPY config/.vimrc /home/ubuntu/.vimrc
COPY config/.tmux /home/ubuntu/.tmux
COPY config/.tmux.conf /home/ubuntu/.tmux.conf

RUN chown -R ubuntu:ubuntu /home/ubuntu/.oh-my-zsh /home/ubuntu/.zshrc /home/ubuntu/.p10k.zsh \
    /home/ubuntu/.vimrc /home/ubuntu/.tmux /home/ubuntu/.tmux.conf || true

# 开发与 GUI 工具（Gazebo 需要时解注释）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      zsh git vim wget tmux \
      python3-pip python3-colcon-common-extensions python3-rosdep \
      gcc g++ gdb clangd cmake make lsb-release gnupg \
      ros-${ROS_DISTRO}-turtlesim \
      ros-${ROS_DISTRO}-rviz2 \
      ros-${ROS_DISTRO}-rqt \
      # ros-${ROS_DISTRO}-gazebo-ros-pkgs \
      # gazebo \
    && rm -rf /var/lib/apt/lists/*

# rosdep（失败不阻塞构建）
RUN rosdep init 2>/dev/null || true && rosdep update || true

# 不覆盖基镜像 CMD/ENTRYPOINT（保留 noVNC/桌面）
EXPOSE 80 5901

# 设置用户和工作目录
USER root
WORKDIR /root
