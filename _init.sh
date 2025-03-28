#!/bin/bash

# 检查是否已经安装 git
if ! command -v git &> /dev/null; then
    echo "git 未安装，正在安装..."
    apt install -y git
else
    echo "git 已安装，跳过安装。"
fi

apt install -y python3
apt install -y python3-pip
apt install -y python3.12-venv
apt install -y cron

# 克隆 Git 仓库
if [ ! -d "ddd" ]; then
    echo "克隆 Git 仓库..."
    git clone https://github.com/tomi88001/ddd.git
else
    echo "仓库已存在，跳过克隆。"
fi

# 进入仓库目录
cd ddd || { echo "目录 'ddd' 不存在，退出脚本"; exit 1; }

# 打印当前工作目录，确保进入了 'ddd' 目录
echo "当前工作目录：$(pwd)"


echo "脚本执行完毕！"
