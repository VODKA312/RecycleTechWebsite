# RecycleTech 简单部署指南

## 🚀 快速开始

### 1. 自动部署（推荐）

#### 开发流程
```bash
# 在dev分支开发
git checkout dev
git add .
git commit -m "更新功能"
git push origin dev  # 自动部署到测试环境
```

#### 发布生产版本
```bash
# 创建发布标签
git tag release-v1.0.0
git push origin release-v1.0.0  # 自动部署到生产环境
```

### 2. 手动部署

#### Windows用户
```cmd
# 双击运行
deploy\deploy.bat staging    # 测试环境
deploy\deploy.bat production # 生产环境
```

#### Linux/Mac用户
```bash
# 给脚本添加执行权限
chmod +x deploy/*.sh

# 运行部署脚本
./deploy/quick_deploy.sh staging    # 测试环境
./deploy/quick_deploy.sh production # 生产环境
```

## 📁 项目结构

```
RecycleTechWebsite/
├── .github/workflows/     # GitHub Actions自动部署
├── deploy/                # 部署相关文件
│   ├── deploy.sh         # 主要部署脚本
│   ├── quick_deploy.sh   # 快速部署脚本
│   ├── deploy.bat        # Windows部署脚本
│   ├── nginx.conf        # Nginx配置
│   ├── systemd.service   # 系统服务配置
│   └── settings_production.py # 生产环境配置
├── RecycleTech/          # Django项目配置
├── RecycleTechApp/       # Django应用
└── requirements.txt       # Python依赖
```

## ⚙️ 配置说明

### 1. 环境变量配置
```bash
# 复制配置文件
cp deploy/config.env.example deploy/.env

# 编辑配置文件，填写服务器信息
# 主要配置项：
SERVER_HOST=your-server-ip      # 服务器IP
SERVER_USER=deploy              # 部署用户
DOMAIN_NAME=your-domain.com     # 域名
```

### 2. 服务器要求
- Ubuntu 18.04+ 或 CentOS 7+
- Python 3.8+
- Nginx
- 2GB+ RAM
- 10GB+ 磁盘空间

## 🔧 服务器初始化

### 首次部署
```bash
# 1. 上传代码到服务器
# 2. 运行初始化脚本
cd deploy
sudo bash setup_server.sh

# 3. 修改配置文件
sudo nano deploy/.env

# 4. 运行部署
sudo bash deploy.sh production
```

## 📋 部署检查清单

- [ ] 服务器已安装Python、Nginx
- [ ] 配置文件已填写正确的服务器信息
- [ ] 域名已解析到服务器IP
- [ ] 防火墙已开放80、443端口
- [ ] 数据库已创建并配置
- [ ] 静态文件已收集
- [ ] 服务已启动并运行

## 🐛 常见问题

### 1. 权限问题
```bash
# 修复目录权限
sudo chown -R www-data:www-data /var/www/recycletech
sudo chmod -R 755 /var/www/recycletech
```

### 2. 服务无法启动
```bash
# 检查服务状态
sudo systemctl status recycletech
sudo systemctl status nginx

# 查看日志
sudo journalctl -u recycletech -f
sudo tail -f /var/log/nginx/error.log
```

### 3. 静态文件无法访问
```bash
# 重新收集静态文件
python manage.py collectstatic --noinput

# 检查Nginx配置
sudo nginx -t
sudo systemctl reload nginx
```

## 🔒 安全建议

1. **生产环境设置**
   - 设置 `DEBUG = False`
   - 使用强密码和安全的SECRET_KEY
   - 配置HTTPS（SSL证书）

2. **服务器安全**
   - 定期更新系统包
   - 配置防火墙规则
   - 使用SSH密钥认证
   - 定期备份数据

## 📞 技术支持

如果遇到问题，请检查：
1. 部署日志
2. 服务状态
3. 配置文件
4. 服务器资源使用情况

---

**注意**: 这是一个简化的部署流程，适合小型项目使用。对于生产环境，建议根据实际需求调整配置和安全设置。 