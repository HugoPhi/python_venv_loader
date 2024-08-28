fnew() {
    # 如果接收到 new 选项，创建虚拟环境
    
    if [[ -z $v ]]; then  # 如果没有指定版本
        if [[ -z $m ]]; then
            VENV_NEW=$(python --version | awk '{print $2}')
        else
            out="${m// /_}"  # 将空格替换为'_'
            VENV_NEW=$(python --version | awk '{print $2}')
            VENV_NEW="$VENV_NEW-$out"
        fi
    else
        if [[ ! -d "$PYENV_PYTHON/versions/$v" ]]; then  # 查看是否有这个版本
            echo "pyenv version not found, please use pyenv to install Python $PYENV_PYTHON"
            return 1
        fi
        
        if [[ -z $m ]]; then
            VENV_NEW=$($PYENV_PYTHON/versions/$v/bin/python --version | awk '{print $2}')
        else
            out="${m// /_}"  # 将空格替换为'_'
            VENV_NEW=$($PYENV_PYTHON/versions/$v/bin/python --version | awk '{print $2}')
            VENV_NEW="$VENV_NEW-$out"
        fi
    fi
    
    if [ -d "$VENV_DIR/$VENV_NEW" ]; then
        echo "环境已经被创建，请勿重复操作."
        return 1
    elif [[ $VENV_NEW == -* ]]; then
        echo "命名格式错误，不要以'-'开头"
        return 1
    else
        echo "creating gloal python venv $VENV_NEW ..."
        if [[ -n $u ]]; then  # 下载pip环境文件
            curl -o ./env.txt $u
            f="./env.txt"
        fi
        
        if [[ -z $v ]]; then
            if [[ -z $f ]]; then
                python -m venv "$VENV_DIR/$VENV_NEW"
            else
                python -m venv "$VENV_DIR/$VENV_NEW" && source "$VENV_DIR/$VENV_NEW"/bin/activate && pip install -r $f && deactivate
            fi
        else
            if [[ -z $f ]]; then
                $PYENV_PYTHON/versions/$v/bin/python -m venv "$VENV_DIR/$VENV_NEW"
            else
                $PYENV_PYTHON/versions/$v/bin/python -m venv "$VENV_DIR/$VENV_NEW" && source "$VENV_DIR/$VENV_NEW"/bin/activate && pip install -r $f && deactivate
            fi
        fi
        
        if [[ -n $u ]]; then
            rm ./env.txt
        fi
        
        echo "  created $VENV_NEW! 🌟"
    fi
}
