# RecycleTech 部署指南

## 概述
这是一个简单的CI/CD部署流程，用于将RecycleTech网站自动部署到生产服务器。

## 部署流程

### 1. 开发流程
- 在 `dev` 分支进行开发
- 提交代码到 `dev` 分支会触发测试环境部署
- 创建 `release-*` 标签会触发生产环境部署

### 2. 自动部署触发条件
- **测试环境**: 推送代码到 `dev` 分支
- **生产环境**: 创建以 `release-` 开头的标签

### 3. 部署步骤
1. 代码检查
2. 依赖安装
3. 测试运行
4. 静态文件收集
5. 代码同步到服务器
6. 数据库迁移
7. 服务重启

## 服务器配置

### 1. 目录结构
```
/var/www/recycletech/          # 项目根目录
├── manage.py
├── RecycleTech/               # Django项目配置
├── RecycleTechApp/            # Django应用
├── staticfiles/               # 静态文件
├── media/                     # 媒体文件
└── venv/                      # 虚拟环境
```

### 2. 服务配置
- **Django应用**: systemd服务 `recycletech`
- **Web服务器**: Nginx
- **端口**: 8000 (Django), 80/443 (Nginx)

### 3. 环境变量
```bash
DJANGO_SETTINGS_MODULE=RecycleTech.settings_production
PYTHONPATH=/var/www/recycletech
```

## 使用方法

### 1. 首次部署
```bash
# 在服务器上创建目录
sudo mkdir -p /var/www/recycletech
sudo chown www-data:www-data /var/www/recycletech

# 复制配置文件
sudo cp deploy/nginx.conf /etc/nginx/sites-available/recycletech
sudo cp deploy/systemd.service /etc/systemd/system/recycletech.service

# 启用服务
sudo systemctl enable recycletech
sudo systemctl enable nginx
```

### 2. 手动部署
```bash
# 测试环境
./deploy/deploy.sh staging

# 生产环境
./deploy/deploy.sh production
```

### 3. 自动部署
```bash
# 创建发布标签
git tag release-v1.0.0
git push origin release-v1.0.0

# 或者推送到dev分支
git push origin dev
```

## 配置修改

### 1. 服务器信息
修改 `deploy/deploy.sh` 中的以下变量：
- `SERVER_HOST`: 服务器IP地址
- `SERVER_PATH`: 服务器项目路径
- `DEPLOY_USER`: 部署用户

### 2. 域名配置
修改 `deploy/nginx.conf` 中的域名：
- 将 `your-domain.com` 替换为实际域名

### 3. 环境配置
修改 `deploy/settings_production.py` 中的配置：
- `ALLOWED_HOSTS`: 允许访问的主机
- 数据库配置
- 日志配置

## 故障排除

### 1. 常见问题
- **权限问题**: 确保 `www-data` 用户有项目目录的读写权限
- **端口冲突**: 检查8000端口是否被占用
- **依赖问题**: 确保虚拟环境中安装了所有依赖

### 2. 日志查看
```bash
# Django日志
sudo tail -f /var/log/recycletech/django.log

# 服务状态
sudo systemctl status recycletech
sudo systemctl status nginx

# Nginx日志
sudo tail -f /var/log/nginx/error.log
```

## 安全注意事项

1. 生产环境必须设置 `DEBUG = False`
2. 使用强密码和安全的SECRET_KEY
3. 定期更新依赖包
4. 配置防火墙规则
5. 使用HTTPS（SSL证书）
6. 定期备份数据库和代码 