fclone() {
    # 如果接收到 clone 选项，克隆虚拟环境
    if [[ -z $v ]]; then
        PYTHON="python"
    else
        if [[ ! -d "$PYENV_PYTHON/versions/$v" ]]; then
            echo "pyenv 没有找到这个环境，请通过\`pyenv install\`下载 Python $v"
            return 1
        fi
        
        PYTHON="$PYENV_PYTHON/versions/$v/bin/python"
    fi
    
    if [[ -n $c ]]; then
        out="${c// /_}"
        VENV_NAME=$($PYTHON --version | awk '{print $2}')
        VENV_NAME="$VENV_NAME-$out"
        TAR="$VENV_DIR/$VENV_NAME"
        
        if [[ ! -d ".venv" ]]; then
            echo "当前路径没有.venv. "
            return 1
        fi
        source .venv/bin/activate
    elif [[ -n $p ]]; then
        VENV_NAME=".venv"
        TAR="./.venv"
        
        if [[ ! -d "$VENV_DIR/$p" ]]; then
            echo "没有全局虚拟环境：$p."
            return 1
        fi
        source "$VENV_DIR/$p/bin/activate"
    elif [[ -n $b && -n $b2 ]]; then
        out="${b2// /_}"
        VENV_NAME=$($PYTHON --version | awk '{print $2}')
        VENV_NAME="$VENV_NAME-$out"
        TAR="$VENV_DIR/$VENV_NAME"
        
        if [[ ! -d "$VENV_DIR/$b" ]]; then
            echo "没有全局虚拟环境：$b."
            return 1
        fi
        source "$VENV_DIR/$b/bin/activate"
    elif [[ -n $b ]]; then
        VENV_NAME=$($PYTHON --version | awk '{print $2}')
        TAR="$VENV_DIR/$VENV_NAME"
        
        if [[ ! -d "$VENV_DIR/$b" ]]; then
            echo "没有全局虚拟环境：$b."
            return 1
        fi
        source "$VENV_DIR/$b/bin/activate"
    else
        echo "参数错误."
        return 1
    fi
    
    if [[ -d "$TAR" ]]; then
        echo "环境已经被创建，请勿重复操作."
        deactivate
        return 1
    fi
    
    pip list --not-required | awk 'NR>2 {print $1}' > env.txt
    deactivate
    $PYTHON -m venv $TAR && source "$TAR/bin/activate" && pip install -r env.txt && deactivate
    rm ./env.txt
    
    if [[ -n $c ]]; then
        echo "已经将.venv克隆到全局的$VENV_NAME ."
    elif [[ -n $p ]]; then
        echo "已经将全局的$p克隆到$VENV_NAME ."
    elif [[ -n $b ]]; then
        echo "已经将全局的$b克隆到全局的$VENV_NAME"
    fi
}
