fhelp() {
    if [[ "$h" == "new" ]]; then
        echo "pload new {[参数] [信息]}"
        echo ""
        echo "・None: 使用当前python版本作为版本名称创建虚拟环境"
        echo "・'-m(essage)': 在后面添加该环境用途：比如:torch,tensorflow-1.15.0-cuda等等，作为[信息]，注意有空格要加引号"
        echo "・'-f(ile)': 通过pip配置文件创建python虚拟环境."
        echo "・'-u(rl)' : 通过网上的pip配置文件创建python虚拟环境."
        echo "・'-v(ersion)': 制定python环境."
        echo ""
        echo "* e.g.1, python-version==3.8.19"
        echo "  命令: \`pload new\`"
        echo "  解释: 如果没有被创建，会在$VENV_DIR创建一个名为3.8.19的环境"
        echo ""
        echo "* e.g.2, python-version==3.8.19"
        echo "  命令: \`pload new -m "pytorch hao hao xue xi"\`"
        echo "  解释: 如果没有被创建，会在$VENV_DIR创建一个名为3.8.19-pytorch_hao_hao_xue_xi的环境"
    elif [[ "$h" == "rm" ]]; then
        echo "pload rm [信息]"
        echo ""
        echo "删除[信息]中提供的全局虚拟环境，使用list出来的全局虚拟环境名称作为参数，支持正则表达式"
        echo ""
        echo "* e.g.1"
        echo "  命令: \`pload rm 3.8.19 3.8.19-pytorch_hao_hao_xue_xi\`"
        echo "  解释: 删除全局虚拟环境3.8.19和3.8.19-pytorch_hao_hao_xue_xi"
    elif [[ "$h" == "clone" ]]; then 
        echo "pload clone {[选项] [信息]}"
    elif [[ "$h" == "list" ]]; then
        echo "pload list {[选项] [信息]}"
        echo ""
        echo "・None: 列出所有全局虚拟环境名称"
        echo "・'-s(earch)': 列出所有全局虚拟环境名称完整包含该参数"
    else
        echo "用法: pload [选项/全局环境名称] {[参数] [自定义信息]}"
        echo ""
        echo "📖 选项 & 参数"
        echo "・new  : 创建虚拟环境"
        echo "・rm   : 删除全局虚拟环境"
        echo "・clone: 克隆虚拟环境(TODO)"
        echo "・list : 列出所有全局虚拟环境名称"
        echo "・setup: 加载当前目录下的 .venv"
    fi
    
    return 0
}
