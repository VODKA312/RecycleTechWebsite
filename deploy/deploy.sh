#!/bin/bash

# RecycleTech 部署脚本
# 使用方法: ./deploy.sh [staging|production]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 配置变量
PROJECT_NAME="RecycleTech"
APP_NAME="RecycleTechApp"
DEPLOY_USER="deploy"
SERVER_HOST="your-server-ip"
SERVER_PATH="/var/www/recycletech"
BACKUP_PATH="/var/backups/recycletech"

# 环境检查
ENVIRONMENT=${1:-staging}

echo -e "${GREEN}开始部署 ${PROJECT_NAME} 到 ${ENVIRONMENT} 环境...${NC}"

# 创建备份
echo -e "${YELLOW}创建备份...${NC}"
ssh ${DEPLOY_USER}@${SERVER_HOST} "mkdir -p ${BACKUP_PATH} && cp -r ${SERVER_PATH} ${BACKUP_PATH}/backup-$(date +%Y%m%d-%H%M%S)"

# 同步代码到服务器
echo -e "${YELLOW}同步代码到服务器...${NC}"
rsync -avz --exclude='.git' --exclude='__pycache__' --exclude='*.pyc' --exclude='.env' ./ ${DEPLOY_USER}@${SERVER_HOST}:${SERVER_PATH}/

# 在服务器上执行部署命令
echo -e "${YELLOW}在服务器上执行部署命令...${NC}"
ssh ${DEPLOY_USER}@${SERVER_HOST} << 'EOF'
    cd /var/www/recycletech
    
    # 激活虚拟环境（如果有的话）
    if [ -d "venv" ]; then
        source venv/bin/activate
    fi
    
    # 安装依赖
    pip install -r requirements.txt
    
    # 收集静态文件
    python manage.py collectstatic --noinput
    
    # 运行数据库迁移
    python manage.py migrate
    
    # 重启服务
    sudo systemctl restart recycletech
    sudo systemctl restart nginx
    
    echo "部署完成！"
EOF

echo -e "${GREEN}部署成功完成！${NC}"
echo -e "${YELLOW}网站地址: http://${SERVER_HOST}${NC}" 