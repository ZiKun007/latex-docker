## 1. 如何解决Mac上在docker容器中使用用户界面的问题？
> [参考链接](https://openprompt.co/conversations/4577)

在 macOS 上使用 Docker 运行需要图形用户界面(GUI) 的应用程序，例如 ROS2 的 turtlesim，需要一些额外的设置来使图形界面能够显示。下面是一个基于 **XQuartz** 和社区反馈的解决方案步骤：

1. **安装 XQuartz**
可以从 XQuartz 官网 下载最新版本并安装。运行 XQuartz 并配置：
   - 在 XQuartz 的偏好设置中，前往 “安全” 选项卡，勾选 “允许来自网络客户端的连接”。

   - 为了让设置生效，完全退出并重新启动 XQuartz

配置 Docker 容器以使用 XQuartz
- 在终端中，使用 `ipconfig getifaddr en0` (对于 Wi-Fi 连接) 或 `ipconfig getifaddr en1` (对于有线连接) 来获取你的 IP 地址。

- 允许 XQuartz 接受来自该 IP 地址的连接，在终端中运行 xhost + <你的IP地址> 来允许连接。
举例：如果你的 IP 地址是 192.168.1.5，则运行 xhost + 192.168.1.5。

- 在运行 Docker 容器时，你需要设置环境变量 DISPLAY 来指向你的 macOS 主机的 IP 地址，并确保容器安装了所有必要的库来支持图形界面。这里是一个基本的示例命令：

```sh
docker run -it --rm \
    -e DISPLAY=<你的IP地址>:0 \
    <你的Docker镜像> \
    ros2 run turtlesim turtlesim_node
```
替换 <你的IP地址> 和 <你的Docker镜像> 为实际的值。

这个解决方案让你能够在 macOS 上通过 Docker 容器运行需要图形用户界面的应用程序，像是 ROS2 的 turtlesim。不过，根据你的具体需求和安全考虑，可能需要做一些调整。

2. **注意**：这个解决方案假设你的 Docker 容器已经安装了 ROS2 和 turtlesim，以及所有必要的图形界面依赖项。如果没有，你需要在构建 Docker 镜像时添加必要的安装命令。

3. **安全提示**
使用 xhost + 允许所有客户端连接可能存在安全隐患。一旦你完成了工作，用 xhost - 命令来撤销访问权限，或者更安全地，只允许特定的 IP 地址连接。

4. **测试可用**
可以利用如下绘图的Python脚本测试一下能否在容器中调用宿主机的绘图界面：
```python
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-1, 1, 50)
y = 2 * x

plt.plot(x, y)
plt.show()
```

---

## 2. 在Ubuntu中使用ROS容器时，如何显示GUI？
> [Docker容器应用可视化-X11方式](https://blog.csdn.net/weixin_56291477/article/details/131857032)

首先在宿主机上启动X11服务：
```sh
xhost +
```

然后使用如下方法创建容器：

```sh
docker run -it \
    --name uros1 \
    --net=host \    # 与宿主机共享网络
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    ros1:u20 \
    /bin/zsh
# --env="DISPLAY" \
# --env="QT_X11_NO_MITSHM=1" \
```

---

## 3. 在容器中使用Latex时，字体缺失的问题？

1. 中文字体缺失解决方案：

```sh
# 更新系统软件包列表：
sudo apt update

# 安装中文字体支持包：这将安装Noto字体系列，其中包含了广泛的中文字体
sudo apt install fonts-noto-cjk

# 安装中文字体配置包：
sudo apt install fontconfig

# 配置中文字体：
sudo dpkg-reconfigure fontconfig-config

# 更新字体缓存：
sudo fc-cache -f -v
```

2. 英文字体确实解决方案：

```sh
add-apt-repository multiverse
apt update
apt install ttf-mscorefonts-installer
fc-cache -f -v
```

---

## 4. 如何让DockerDestop访问代理，如何在WSL2中开启代理

如果你在 Windows 宿主机上开启了代理软件（例如 Clash, v2ray 等），你可以直接让 Docker 走这个代理：

1. 打开 Docker Desktop，点击右上角的 ⚙️ Settings (齿轮图标)。 在左侧导航栏选择 Resources -> Proxies。 
    开启 Manual proxy configuration。在 Web Server (HTTP) 和 Secure Web Server (HTTPS) 中填入你的宿主机代理地址。

2. 注意：因为 Docker 运行在虚拟机中，不要填 127.0.0.1，请填入特殊的宿主机域名：
    - 格式通常为：http://host.docker.internal:7890（请把 7890 换成你实际代理软件的本地端口）。
    - 在 Bypass proxy settings... 框中填入：localhost,127.0.0.1,*.local,host.docker.internal 以避免本地流量被误拦截。

3. 点击右下角的 Apply & restart。

[注意] 如果不启用 "Manual proxy configuration" 也能拉取基础镜像，那就不用进行上面的步骤。可以在Windows中拉取基础镜像，然后再在WSL2中构建新的镜像


下面是在WSL2中配置代理的方法：
1. 配置WSL2的`.wslconfig`文件，添加以下内容：
```bash
[wsl2]
# 开启镜像网络模式
networkingMode=mirrored
# 自动同步 Windows 的代理设置（可选）
autoProxy=true
# 允许 WSL 访问 Windows 的本地服务
hostAddressLoopback=true
```

2. 启用代理软件的"允许局域网连接"

3. 在Windows终端中运行命令`reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | findstr Proxy`，查看代理配置, 找到ProxyServer字段对应的端口号。

2. 在WSL2的`.bashrc`或`.zshrc`中添加以下内容，之后使用`proxy_on`开启代理，使用`proxy_off`关闭代理。

```bash
# 获取 WSL2 宿主机 (Windows) 的 IP 地址
# export hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
export hostip="127.0.0.1"

# 代理端口，请根据你的软件实际端口修改 (比如 7890)
export proxy_port="7890"

# 定义开启代理的函数
proxy_on() {
    export http_proxy="http://${hostip}:${proxy_port}"
    export https_proxy="http://${hostip}:${proxy_port}"
    export all_proxy="socks5://${hostip}:${proxy_port}"

    # 排除本地流量，防止 VS Code Server 连接断开
    export no_proxy="localhost,127.0.0.1,::1,host.docker.internal"
    echo -e "已开启代理: http://${hostip}:${proxy_port}"
}

# 定义关闭代理的函数
proxy_off() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo -e "已关闭代理"
}
```
