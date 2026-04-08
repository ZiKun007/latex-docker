# 1. 基础镜像
FROM ubuntu:24.04

# 设置非交互式安装，避免安装过程卡住
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# 2. 系统基础依赖与 LaTeX 环境 (最耗时、最不易变动，放在最前面)
RUN apt-get update && \
    # a. 安装前置依赖，用于添加 multiverse 仓库
    apt-get install -y software-properties-common && \
    add-apt-repository multiverse && \
    apt-get update && \
    # b. 核心操作：自动接受微软字体的 EULA 协议，防止 Docker 构建卡死！
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    # c. 一次性安装所有软件和字体
    apt-get install -y \
    texlive-full \
    biber \
    latexmk \
    git \
    vim \
    zsh \
    curl \
    wget \
    unzip \
    fontconfig \
    fonts-noto-cjk \
    ttf-mscorefonts-installer \
    && rm -rf /var/lib/apt/lists/*

# 3. 配置字体 (较少变动)
# 将本地的 fonts 目录拷贝到系统的中文字体目录下
COPY fonts /usr/share/fonts/custom_latex_fonts
# 统一刷新一次系统字体缓存，包含刚安装的 Noto 和 mscorefonts
RUN fc-cache -fv

# 4. 配置个人终端环境 (最容易变动，放在最后)
# 拷贝本地的 oh-my-zsh 源码
COPY .oh-my-zsh /root/.oh-my-zsh

# 拷贝你的自定义 zsh/vim 配置
COPY config/.vimrc /root/.vimrc
COPY config/.p10k.zsh /root/.p10k.zsh
COPY config/.zshrc /root/.zshrc

# 切换默认 Shell 为 zsh
RUN chsh -s $(which zsh)

# 设置工作目录为挂载点
WORKDIR /workspace

# 容器启动时的默认命令
CMD ["zsh"]