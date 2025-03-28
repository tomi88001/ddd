#!/bin/bash

# 检查是否传入了参数
if [ "$#" -ne 1 ]; then
    echo "使用方法：$0 <xxx>  # 该参数为必填项"
    exit 1
fi
# 停止之前的任务
echo "正在停止之前的任务..."
sh _stop.sh

# 删除旧的虚拟环境（如果有的话）
rm -rf venv

python3 -m venv venv


# 激活虚拟环境
source venv/bin/activate

pip install -r requirements.txt

# 执行 main.py 脚本并传入参数
echo "启动 main.py 脚本..."
python3 main.py GET "$1" 5 100 proxy.txt 100 10800

# 检查 python3 是否成功启动
if [ $? -eq 0 ]; then
    echo "main.py 脚本成功启动"
else
    echo "启动 main.py 脚本失败"
    exit 1
fi
