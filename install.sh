#!/bin/bash

git clone https://github.com/HugoPhi/python_venv_loader.git $HOME/.local/bin/vload

chmod +x $HOME/.local/bin/vload/vload

## 添加man
# 将 man 手册页文件复制到系统的 man 手册路径中
MAN_PATH="/usr/local/share/man/man1"
MAN_FILE="pyloader.1"

# 检查是否有权限写入 man 路径
if [ ! -d "$MAN_PATH" ]; then
    echo "路径 $MAN_PATH 不存在，尝试创建..."
    sudo mkdir -p "$MAN_PATH"
fi

echo "将手册页安装到 $MAN_PATH"
sudo cp "$MAN_FILE" "$MAN_PATH"

# 更新手册页数据库
echo "更新 man 数据库..."
sudo mandb

echo "安装完成！你现在可以使用 'man pload' 查看手册页。"

echo ""
echo ""

### add to terminal config

current_shell=$(basename "$SHELL")

if [ "$current_shell" = "bash" ]; then
    echo 'source $HOME/.local/bin/vload/bash/main.sh' >> ~/.bashrc
elif [ "$current_shell" = "zsh" ]; then
    echo 'source $HOME/.local/bin/vload/zsh/main.zsh' >> ~/.bashrc
else
    echo "当前终端是 $current_shell."
fi


echo '欢迎使用python venv loader!'
echo ''
echo '重启以使用命令`pload`'
echo ''
