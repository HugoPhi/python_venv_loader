flist() {
    # 如果接收到 list 选项，加载所有在.venvs下的环境
    if [[ -z $s ]]; then
        ls -d $VENV_DIR/*/ | awk -F/ '{print $(NF-1)}'
    else
        ls -d $VENV_DIR/*/ | awk -F/ '{print $(NF-1)}' | grep "$s"
    fi
}
