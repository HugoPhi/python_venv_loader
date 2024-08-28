#!/bin/bash

git clone https://github.com/HugoPhi/python_venv_loader.git $HOME/.local/bin/vload

chmod +x $HOME/.local/bin/vload/vload

echo 'source $HOME/.local/bin/vload/main.sh' >> ~/.bashrc
echo '欢迎使用python venv loader!'
echo ''
echo '重启以使用命令`pload`，或者运行下面的命令：'
echo '  `source ~/.local/bin/vload/main.sh`'
echo ''
