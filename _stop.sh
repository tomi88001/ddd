#!/bin/bash

# 检查是否传入了参数
if [ "$#" -gt 1 ]; then
    echo "使用方法：$0 [1]  # 可选的参数 1 仅关闭 main.py"
    exit 1
fi
rm -rf /root/ddd/files/proxies/proxy.txt 
# 获取传入的参数
MODE="$1"

# 如果传入的参数是 1，只关闭 python3 main.py 进程
if [ "$MODE" -eq 1 ]; then
    # 仅停止所有 python3 main.py 进程
    echo "Stopping all 'python3 main.py' processes..."
    for pid in $(pgrep -f 'python3 main.py'); do  # 使用 pgrep -f 来精确匹配整个命令
        echo "Force stopping process with PID: $pid"
        
        # 强制终止进程
        kill -9 "$pid"
        
        # 打印已停止进程的信息
        if ! ps -p "$pid" > /dev/null; then
            echo "Process $pid 已被强制停止"
        else
            echo "Failed to stop process $pid"
        fi
    done
else
    # 如果没有传入参数，默认会停止 main.py 和 _cron.sh 进程，并删除 _cron.sh 的定时任务

    # 停止所有 python3 main.py 进程
    echo "Stopping all 'python3 main.py' processes..."
    for pid in $(pgrep -f 'python3 main.py'); do
        echo "Force stopping process with PID: $pid"
        
        # 强制终止进程
        kill -9 "$pid"
        
        # 打印已停止进程的信息
        if ! ps -p "$pid" > /dev/null; then
            echo "Process $pid 已被强制停止"
        else
            echo "Failed to stop process $pid"
        fi
    done

    # 删除定时任务（cron job）中的 _cron.sh 任务
    echo "Removing cron job for '_cron.sh'..."
    crontab -l | grep '_cron.sh' | while read line; do
        cron_id=$(echo $line | cut -d ' ' -f 1)  # 获取 cron id 或定时任务的唯一标识
        # 删除该定时任务
        (crontab -l | grep -v "$line" ) | crontab -
        echo "Removed cron job: $line"
    done

    # 停止通过 cron 启动的 _cron.sh 任务（假设通过 nohup 启动）
    echo "Stopping all '_cron.sh' tasks started by cron..."
    for pid in $(pgrep -f '_cron.sh'); do  # 使用 pgrep -f 来匹配 _cron.sh 进程
        echo "Force stopping _cron.sh process with PID: $pid"
        
        # 强制终止进程
        kill -9 "$pid"
        
        # 打印已停止进程的信息
        if ! ps -p "$pid" > /dev/null; then
            echo "Process $pid 已被强制停止"
        else
            echo "Failed to stop _cron.sh process $pid"
        fi
    done
fi

# 打印停止后的进程列表
echo "\033[0;31m_stop.sh 执行完 =======================\033[0m"
echo "当前运行的 python3 main.py 进程列表："
ps aux | grep 'python3 main.py' | grep -v grep

echo "当前运行的 _cron.sh 进程列表："
ps aux | grep '_cron.sh' | grep -v grep
