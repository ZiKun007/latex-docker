<div align="right">
  <strong>中文</strong> | <a href="README_en.md">English</a>
</div>

# 📝|🐳 latex-docker: 专为学术写作打造的开箱即用 LaTeX 容器

[![OS](https://img.shields.io/badge/OS-Ubuntu-orange?logo=ubuntu)](https://ubuntu.com/)
[![LaTeX](https://img.shields.io/badge/LaTeX-TeX%20Live%20Full-008080?logo=latex)](https://www.tug.org/texlive/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker)](https://www.docker.com/)

`latex-docker` 是一个高性能、配置完备的 LaTeX 容器化编译环境。旨在彻底解决本地安装 `texlive-full` 带来的环境污染问题，并完美跨越中英文字体缺失、环境不一致等学术写作中的常见障碍。

## 🌟 核心特性 (Key Features)

* **隔离与纯净：** 将 5GB+ 的 LaTeX 环境完全封装在 Docker 中，保持宿主机（Windows/macOS）的绝对纯净。
* **终极字体方案：**
  * 自动化绕过 `ttf-mscorefonts-installer` 的微软 EULA 协议验证，实现无交互顺畅构建。
  * 内置开源 `fonts-noto-cjk`，并支持通过 `fonts/` 目录映射高校模板必备的闭源 Windows 字体（宋体、黑体等）。
* **高效工作流集成：** 内置高度定制的 Zsh + Tmux 终端环境，以及为 macOS/Windows 量身定制的 VS Code LaTeX Snippets 和 Keybindings。
* **缓存优化：** 科学的 Dockerfile 构建层级设计，分离庞大的 TeX Live 层与易变的个人配置层，极大提升二次构建速度。

## 📂 仓库结构 (Directory Structure)

```text
latex-docker/
├── Dockerfile              # 核心构建文件
├── docker-compose.yaml     # 容器编排与目录挂载配置
├── config/                 # 终端环境配置 (Zsh, Tmux, Vim)
├── fonts/                  # 自定义商业中文字体存放处 (需自行放入)
├── latex-settings/         # VS Code 快捷键与代码片段 (macOS & Windows)
├── utils/                  # 环境构建辅助脚本
└── .oh-my-zsh/             # 本地化 Oh My Zsh 源码，确保版本锁定
```

## 🚀 快速开始 (Quick Start)

### 1. 准备工作
* 确保已安装 [Docker](https://www.docker.com/) 和 Docker Compose。
* （可选）将你写论文所需的特定 Windows 字体（如 `simsun.ttc`）放入 `fonts/` 目录。

### 2. 构建与启动
```bash
git clone https://github.com/ZiKun007/latex-docker.git
cd latex-docker

# 在后台构建并启动 LaTeX 容器
docker-compose up -d --build
```

### 3. 配合 VS Code 优雅写作
1. 在宿主机修改 `docker-compose.yaml`，将你的论文源码目录挂载到 `/workspace`：
   ```yaml
   volumes:
     - /path/to/your/paper:/workspace
   ```
2. 安装 VS Code 插件 **LaTeX Workshop**。
3. 将本仓库 `latex-settings/` 目录下的 `latex_snippets.json` 和对应的 `keybinds` 导入到你的 VS Code 用户配置中，享受沉浸式的高效公式输入。

---
**ZiKun** - *Navigation & SLAM Researcher* [My GitHub Profile](https://github.com/ZiKun007)