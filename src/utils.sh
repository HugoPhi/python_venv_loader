# 定义一个函数，用于展开正则表达式并返回匹配的列表
expand_list=()
expand_patterns() {
    patterns=()
    for pattern in $@; do
        patterns+=("$VENV_DIR/$pattern")
    done
    
    # 遍历每个正则表达式
    for pattern in "${patterns[@]}"; do
        # 使用 ls 查找匹配的文件或文件夹，并将结果添加到 matched_items 中, 只保留名称不加路径
        for item in $(ls -d $pattern 2>/dev/null); do
            basename_item=$(basename "$item")
            expand_list+=("$basename_item")
        done
    done
}


