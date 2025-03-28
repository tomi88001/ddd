#!/bin/bash

# 检查是否传入了参数
if [ "$#" -ne 2 ]; then
    echo "使用方法：$0 <xxx> <1-5>  # 该参数为必填项"
    exit 1
fi

python3 -m venv venv

# 激活虚拟环境
. /root/ddd/venv/bin/activate

pip install -r requirements.txt

# 执行 main.py 脚本并传入参数
echo "启动 main.py 脚本..."
python3 main.py GET "$1" "$2" 100 proxy.txt 100 10800

# 检查 python3 是否成功启动
if [ $? -eq 0 ]; then
    echo "main.py 脚本成功启动"
else
    echo "启动 main.py 脚本失败"
    exit 1
fi
