#!/bin/bash

# RecycleTech 快速部署脚本
# 使用方法: ./quick_deploy.sh [staging|production]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 显示帮助信息
show_help() {
    echo -e "${BLUE}RecycleTech 快速部署脚本${NC}"
    echo ""
    echo "使用方法:"
    echo "  $0 [staging|production]"
    echo ""
    echo "参数:"
    echo "  staging    部署到测试环境 (默认)"
    echo "  production 部署到生产环境"
    echo ""
    echo "示例:"
    echo "  $0              # 部署到测试环境"
    echo "  $0 production   # 部署到生产环境"
    echo ""
}

# 检查参数
ENVIRONMENT=${1:-staging}

if [[ "$ENVIRONMENT" != "staging" && "$ENVIRONMENT" != "production" ]]; then
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    echo -e "${RED}错误: 无效的环境参数 '${ENVIRONMENT}'${NC}"
    echo "使用 '$0 -h' 查看帮助信息"
    exit 1
fi

echo -e "${GREEN}开始部署到 ${ENVIRONMENT} 环境...${NC}"

# 检查必要的文件
if [[ ! -f "deploy/deploy.sh" ]]; then
    echo -e "${RED}错误: 找不到部署脚本 deploy/deploy.sh${NC}"
    exit 1
fi

if [[ ! -f "deploy/config.env.example" ]]; then
    echo -e "${YELLOW}警告: 找不到配置文件 deploy/config.env.example${NC}"
fi

# 检查环境变量文件
if [[ ! -f "deploy/.env" ]]; then
    echo -e "${YELLOW}提示: 创建环境变量配置文件...${NC}"
    if [[ -f "deploy/config.env.example" ]]; then
        cp deploy/config.env.example deploy/.env
        echo -e "${YELLOW}请编辑 deploy/.env 文件，填写正确的配置信息${NC}"
        echo -e "${YELLOW}然后重新运行此脚本${NC}"
        exit 1
    fi
fi

# 运行部署脚本
echo -e "${BLUE}执行部署脚本...${NC}"
chmod +x deploy/deploy.sh
./deploy/deploy.sh $ENVIRONMENT

echo -e "${GREEN}部署完成！${NC}"

# 显示后续步骤
echo ""
echo -e "${BLUE}后续步骤:${NC}"
echo "1. 检查服务状态: sudo systemctl status recycletech"
echo "2. 检查Nginx状态: sudo systemctl status nginx"
echo "3. 查看日志: sudo tail -f /var/log/recycletech/django.log"
echo "4. 访问网站: http://your-domain.com"
echo ""
echo -e "${GREEN}部署成功！${NC}" 