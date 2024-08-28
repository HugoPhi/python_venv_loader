#!/bin/bash

# 添加 ~/.local/bin/vload 到 PATH 中
export PATH="$HOME/.local/bin/vload:$PATH"

# python 虚拟环境自动补全函数
_pload_complete() {
    local cur prev opts venvs pyenv_versions new_opts clone_opts entered_opts remaining_opts

    # 获取当前输入和之前输入的命令
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 定义基本的 pload 子命令
    opts="new rm clone list setup -h"

    # 获取全局虚拟环境列表
    venvs=$(ls -1 ~/.venvs 2>/dev/null)

    # 获取 pyenv 版本列表
    pyenv_versions=$(ls -1 ~/.pyenv/versions 2>/dev/null)

    # 定义各子命令的选项
    new_opts="-m -f -u -v"
    clone_opts="-c -p -b -v"

    # 如果只有 'pload'，补全子命令和全局虚拟环境
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${opts} ${venvs}" -- "${cur}") )
        return 0
    fi

    # 已输入的选项
    entered_opts=""

    # 遍历已输入的参数，记录已使用的选项
    for ((i = 2; i < ${COMP_CWORD}; i++)); do
        case "${COMP_WORDS[i]}" in
            -m|-f|-u|-v|-c|-p|-b)
                entered_opts="${entered_opts} ${COMP_WORDS[i]}"
                ;;
        esac
    done

    # 动态确定剩余的补全选项
    case "${COMP_WORDS[1]}" in
        new)
            # 如果之前的选项是 -v，补全 pyenv 版本
            if [[ "${prev}" == "-v" ]]; then
                COMPREPLY=( $(compgen -W "${pyenv_versions}" -- "${cur}") )
            else
                # 获取剩余选项（从 new_opts 中移除已使用的选项）
                remaining_opts=$(echo "${new_opts}" | sed -E "s/(${entered_opts// /|})//g")
                
                if [[ "${cur}" == -* ]]; then
                    # 为 `pload new` 提供剩余选项补全
                    COMPREPLY=( $(compgen -W "${remaining_opts}" -- "${cur}") )
                else
                    # 始终补全全局虚拟环境，除非已经输入 -v
                    COMPREPLY=( $(compgen -W "${venvs}" -- "${cur}") )
                fi
            fi
            ;;
        clone)
            # 获取剩余选项（从 clone_opts 中移除已使用的选项）
            remaining_opts=$(echo "${clone_opts}" | sed -E "s/(${entered_opts// /|})//g")
            
            if [[ "${cur}" == -* ]]; then
                # 为 `pload clone` 提供剩余选项补全
                COMPREPLY=( $(compgen -W "${remaining_opts}" -- "${cur}") )
            else
                # 始终补全全局虚拟环境
                COMPREPLY=( $(compgen -W "${venvs}" -- "${cur}") )
            fi
            ;;
        rm|setup)
            # 为 `pload rm` 和 `pload setup` 提供全局虚拟环境名称的补全
            COMPREPLY=( $(compgen -W "${venvs}" -- "${cur}") )
            ;;
        list)
            # 为 `pload list` 提供选项补全
            COMPREPLY=( $(compgen -W "-s" -- "${cur}") )
            ;;
        *)
            # 默认补全全局虚拟环境名称
            COMPREPLY=( $(compgen -W "${venvs}" -- "${cur}") )
            ;;
    esac

    return 0
}

# 定义 pload 命令，用于加载虚拟环境
pload() {
    . vload "$@"
}

# 将补全函数绑定到 pload 命令
complete -F _pload_complete pload

