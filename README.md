> [!WARNING]   
> This repo has been migrated to [pload](https://github.com/HugoPhi/pload)

# pload: Python Virtual Environment Loader

`python_venv_loader` 是一个 Bash 脚本工具，旨在简化 Python 虚拟环境的管理。通过命令行界面，用户可以高效地创建、删除、克隆和列出虚拟环境。

## # 功能概述

- **创建全局虚拟环境** (`new`): 使用当前 Python 版本或指定版本创建新的全局虚拟环境，存放于 `~/.venvs/` 目录。
- **创建项目虚拟环境** (`init`): 使用当前 Python 版本或指定版本创建新的虚拟环境，存放于当前目录。
- **删除虚拟环境** (`rm`): 删除指定的全局虚拟环境，支持正则表达式匹配。
- **克隆虚拟环境** (`clone`): 在全局和局部环境之间克隆虚拟环境，或在两个全局环境之间克隆。
- **列出虚拟环境** (`list`): 列出所有可用的全局虚拟环境。
- **激活虚拟环境** (`.`): 激活当前目录下的虚拟环境。

## # 安装指南

### 1. 安装 `pyenv`

在使用 `python_venv_loader` 之前，请确保已安装并配置好 `pyenv`，用于管理和切换不同的 Python 版本。

**安装 `pyenv`：**

- 使用 `curl` 安装：
    ```bash
    curl https://pyenv.run | bash
    ```

- 添加以下内容到你的 `~/.bashrc` 或 `~/.zshrc` 文件中以初始化 `pyenv`：
    ```bash
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    ```

- 重新加载 shell 配置文件：
    ```bash
    source ~/.bashrc  # 或者 source ~/.zshrc
    ```

- 确认 `pyenv` 安装成功：
    ```bash
    pyenv --version
    ```

### 2. 安装 `python_venv_loader`

- 运行以下命令以下载并运行安装脚本：
    ```bash
    curl -O https://raw.githubusercontent.com/HugoPhi/pload/main/install.sh
    bash install.sh
    ```

该脚本将自动安装必要的依赖项并配置环境。

## # 使用说明

- **全局创建虚拟环境**
  ```bash
  pload new -v [python版本] -m "[环境用途]"
  ```
  - `-v`: 指定 Python 版本。
  - `-m`: 添加环境用途描述。

  **示例**
  - 创建名为 `3.8.19` 的虚拟环境：
    ```bash
    pload new -v 3.8.19
    ```
  - 创建带描述的虚拟环境：
    ```bash
    pload new -v 3.8.19 -m "pytorch hao hao xue xi"
    ```

- **本地创建虚拟环境**
  ```bash
  pload init -v [python版本]
  ```
  - `-v`: 指定 Python 版本。

  **说明**
  - 该命令会在当前目录下创建一个名为 `.venv` 的虚拟环境。
  - 与全局创建虚拟环境不同，本地创建的环境不会添加用途描述 (`-m` 参数无效)。
  - 本地虚拟环境适用于项目级别的隔离，便于与项目代码一起管理。

  **示例**
  - 在当前目录下创建 Python 3.8.19 的虚拟环境：
    ```bash
    pload init -v 3.8.19
    ```

- **删除虚拟环境**
  ```bash
  pload rm [虚拟环境名称]
  ```
  **示例**
  - 删除环境 `3.8.19` 和 `3.8.19-pytorch_hao_hao_xue_xi`：
    ```bash
    pload rm 3.8.19 3.8.19-pytorch_hao_hao_xue_xi
    ```
  - 使用正则表达式删除前缀为 `3.8.19-` 的所有环境：
    ```bash
    pload rm 3.8.19-*
    ```
   
  但是对于本地的虚拟环境直接删了就行，就是：

  ```bash
  rm -rf .venv
  ```

- **克隆虚拟环境**
  ```bash
  pload clone [选项] [信息]
  ```
  **选项**
  - `-c`: 将当前目录的 `.venv` 环境克隆到全局。
  - `-p`: 从全局克隆到当前目录的 `.venv` 环境。
  - `-b`: 将一个全局虚拟环境克隆到另一个。
  - `-v`: 指定要克隆的全局虚拟环境名称。

  **示例**
  - 将当前目录的环境克隆到全局：
    ```bash
    pload clone -c myenv
    ```
  - 从全局克隆到当前目录的环境：
    ```bash
    pload clone -p
    ```
  - 在两个全局环境之间克隆：
    ```bash
    pload clone -b myenv toenv
    ```

- **列出虚拟环境**
  ```bash
  pload list
  ```
  列出所有全局虚拟环境名称。

- **激活虚拟环境**
  - 本地：

  ```bash
  pload .
  ```
  激活当前目录下的 `.venv` 环境。

  - 全局：
  ```
  pload [全局虚拟环境的名字]
  ```

## # 自动补全

该脚本支持 Bash/Zsh 自动补全功能，并提供man文档。

## License

> This project is licensed under the terms of the MIT. See LICENSE for more details.
