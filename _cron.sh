#!/bin/bash

# 检查是否传入了参数
if [ "$#" -ne 2 ]; then
    echo "使用方法：$0 <xxx>  # 该参数为必填项"
    exit 1
fi
# 获取传入的参数
PARAM="$1"
PARAM2=$2

# 定义定时任务脚本的路径
CRON_SCRIPT_PATH="/root/ddd/_start.sh"  # 请根据实际路径修改

# 定义定时任务的执行频率
CRON_SCHEDULE="0 */2 * * *"  # 每隔 2 小时执行一次

# 强制删除已存在的定时任务
crontab -l | grep "$CRON_SCRIPT_PATH" > /dev/null
if [ $? -eq 0 ]; then
    echo "找到已存在的定时任务，删除该定时任务..."
    crontab -l | grep -v "$CRON_SCRIPT_PATH" | crontab -
    echo "已删除旧的定时任务。"
fi

# 设置新的定时任务
echo "设置新的定时任务..."
(crontab -l 2>/dev/null; echo "$CRON_SCHEDULE $CRON_SCRIPT_PATH $PARAM $PARAM2") | crontab -
echo "新的定时任务已设置。"

# 立即执行一次脚本
echo "立即执行脚本..."
sudo sh $CRON_SCRIPT_PATH $PARAM $PARAM2
