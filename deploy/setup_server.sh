#!/bin/bash

# 服务器初始化脚本
# 使用方法: 在服务器上运行此脚本进行初始设置

set -e

echo "开始初始化 RecycleTech 服务器环境..."

# 更新系统
echo "更新系统包..."
sudo apt update && sudo apt upgrade -y

# 安装必要的软件包
echo "安装必要的软件包..."
sudo apt install -y python3 python3-pip python3-venv nginx git curl

# 创建项目目录
echo "创建项目目录..."
sudo mkdir -p /var/www/recycletech
sudo mkdir -p /var/log/recycletech
sudo mkdir -p /var/backups/recycletech

# 设置权限
echo "设置目录权限..."
sudo chown -R www-data:www-data /var/www/recycletech
sudo chown -R www-data:www-data /var/log/recycletech
sudo chown -R www-data:www-data /var/backups/recycletech

# 创建虚拟环境
echo "创建Python虚拟环境..."
cd /var/www/recycletech
sudo -u www-data python3 -m venv venv

# 配置Nginx
echo "配置Nginx..."
sudo cp nginx.conf /etc/nginx/sites-available/recycletech
sudo ln -sf /etc/nginx/sites-available/recycletech /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# 配置systemd服务
echo "配置systemd服务..."
sudo cp systemd.service /etc/systemd/system/recycletech.service
sudo systemctl daemon-reload
sudo systemctl enable recycletech

# 创建日志目录
echo "创建日志目录..."
sudo mkdir -p /var/log/recycletech
sudo chown www-data:www-data /var/log/recycletech

# 配置防火墙（可选）
echo "配置防火墙..."
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable

# 设置SSL证书（可选，需要域名）
echo "SSL证书配置..."
read -p "是否配置SSL证书？(y/n): " ssl_choice
if [ "$ssl_choice" = "y" ]; then
    sudo apt install -y certbot python3-certbot-nginx
    read -p "请输入域名: " domain_name
    sudo certbot --nginx -d $domain_name
fi

# 重启服务
echo "重启服务..."
sudo systemctl restart nginx
sudo systemctl status nginx

echo "服务器初始化完成！"
echo "请确保："
echo "1. 将代码部署到 /var/www/recycletech 目录"
echo "2. 修改配置文件中的域名和服务器信息"
echo "3. 运行数据库迁移"
echo "4. 收集静态文件"
echo "5. 启动Django服务" 