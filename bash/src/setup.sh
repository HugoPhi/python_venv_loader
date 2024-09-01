fsetup() {
    # 如果接收到 setup 选项，加载当前路径下的 .venv
    if [ -d ".venv" ]; then
        source ".venv/bin/activate"
    else
        echo "当前路径下没有找到 .venv 目录."
        return 1
    fi
}

