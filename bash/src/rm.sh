frm() {
    # 如果接收到 rm 选项，删除全局虚拟环境
    
    delist_origin=("${non_option_args[@]:1}")
    
    # 展开正则表达式
    expand_patterns "${delist_origin[@]}"
    delist=( ${expand_list[@]} )
    
    if [ ${#delist[@]} -eq 0 ]; then
        echo "请输入要删除的全局环境."
        return 1
    fi
    
    fail=()
    success=()
    for x in "${delist[@]}"; do
        VENV_DELETE="$x"
        
        if [[ $x == ".venv" ]]; then
            TAR=".venv"
        else
            TAR="$VENV_DIR/$VENV_DELETE"
        fi
        
        if [[ ! -d "$TAR" ]]; then 
            echo "不存在虚拟环境 $VENV_DELETE."
        fi
        
        read -p "请输入\`$VENV_DELETE\`以删除这个环境: " input
        if [[ "$input" == "$VENV_DELETE" ]]; then
            rm -rf "$TAR"
            echo "  ✅$VENV_DELETE 已经被删除."
            success+=("$VENV_DELETE")
        else
            echo "  ❌输入错误."
            fail+=("$x")
        fi
    done
    
    echo ""
    if [ ${#success[@]} -gt 0 ]; then
        echo "以下虚拟环境删除成功:"
        echo "${success[@]}"
    fi
    if [ ${#fail[@]} -gt 0 ]; then
        echo "以下虚拟环境删除失败:"
        for x in "${fail[@]}"; do
            echo "$x"
        done
    fi
}
