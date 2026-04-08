
<div align="right">
  <a href="README.md">中文</a> | <strong>English</strong>
</div>

# 📝|🐳 latex-docker: Out-of-the-Box LaTeX Container for Academic Writing

[![OS](https://img.shields.io/badge/OS-Ubuntu-orange?logo=ubuntu)](https://ubuntu.com/)
[![LaTeX](https://img.shields.io/badge/LaTeX-TeX%20Live%20Full-008080?logo=latex)](https://www.tug.org/texlive/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker)](https://www.docker.com/)

`latex-docker` is a high-performance, fully-configured containerized LaTeX compilation environment. It aims to eliminate the system pollution caused by local `texlive-full` installations and flawlessly overcome common academic writing hurdles, such as missing CJK/English fonts and environment inconsistencies.

## 🌟 Key Features

* **Isolation & Purity:** Encapsulates the massive 5GB+ LaTeX environment entirely within Docker, keeping your host machine (Windows/macOS) absolutely clean.
* **Ultimate Font Solution:**
  * Automatically bypasses the Microsoft EULA verification for `ttf-mscorefonts-installer`, ensuring a smooth, non-interactive build.
  * Built-in `fonts-noto-cjk` support, with the ability to map closed-source Windows fonts (required by many university templates) via the `fonts/` directory.
* **Workflow Integration:** Comes with a highly customized Zsh + Tmux terminal environment, along with tailored VS Code LaTeX Snippets and Keybindings for both macOS and Windows.
* **Layer Caching Optimization:** A scientifically designed Dockerfile hierarchy separates the massive TeX Live layer from volatile personal configurations, drastically improving rebuild speeds.

## 📂 Directory Structure

```text
latex-docker/
├── Dockerfile              # Core build file
├── docker-compose.yaml     # Container orchestration & volume mounts
├── config/                 # Terminal configs (Zsh, Tmux, Vim)
├── fonts/                  # Custom commercial CJK fonts (add your own)
├── latex-settings/         # VS Code Keybindings & Snippets (macOS/Windows)
├── utils/                  # Helper scripts for environment setup
└── .oh-my-zsh/             # Localized Oh My Zsh source for version lock
```

## 🚀 Quick Start

### 1. Prerequisites
* Ensure [Docker](https://www.docker.com/) and Docker Compose are installed.
* (Optional) Place any specific Windows fonts (e.g., `simsun.ttc`) required by your paper template into the `fonts/` directory.

### 2. Build & Run
```bash
git clone https://github.com/ZiKun007/latex-docker.git
cd latex-docker

# Build and start the LaTeX container in the background
docker-compose up -d --build
```

### 3. Elegant Writing with VS Code
1. Modify `docker-compose.yaml` on your host to mount your paper's source code directory to `/workspace`:
   ```yaml
   volumes:
     - /path/to/your/paper:/workspace
   ```
2. Install the **LaTeX Workshop** extension in VS Code.
3. Import the `latex_snippets.json` and corresponding `keybinds` from the `latex-settings/` directory into your VS Code user configuration to enjoy immersive and highly efficient math typing.

---
**ZiKun** - *Navigation & SLAM Researcher* [My GitHub Profile](https://github.com/ZiKun007)