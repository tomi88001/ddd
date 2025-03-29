#!/bin/bash

# 检查是否传入了两个参数
if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
    echo "使用方法：$0 <xxx> <1-5>  # 该参数为必填项"
    exit 1
fi

# 如果传入第三个参数为1，则执行停止操作
if [ "$#" -eq 3 ] && [ "$3" -eq 1 ]; then
    echo "停止操作：执行 _stop.sh"
    sudo sh /root/ddd/_stop.sh $3
fi

# 创建虚拟环境
python3 -m venv venv

# 激活虚拟环境
. /root/ddd/venv/bin/activate

# 安装依赖
pip install -r requirements.txt

# 执行 main.py 脚本并传入参数
echo "启动 main.py 脚本..."
rm -rf ./files/proxies/proxy.txt
python3 main.py GET "$1" "$2" 400 proxy.txt 100 10800

# 检查 python3 是否成功启动
if [ $? -eq 0 ]; then
    echo "main.py 脚本成功启动"
else
    echo "启动 main.py 脚本失败"
    exit 1
fi
