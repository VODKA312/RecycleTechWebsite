# 使用Python 3.9官方镜像作为基础镜像
FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=RecycleTech.settings_production

# 安装系统依赖
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        libpq-dev \
        curl \
    && rm -rf /var/lib/apt/lists/*

# 复制requirements文件
COPY requirements-docker.txt .

# 安装Python依赖（优化缓存）
RUN pip install --no-cache-dir -r requirements-docker.txt && \
    pip cache purge

# 复制项目代码
COPY . .

# 创建必要的目录
RUN mkdir -p /app/staticfiles /app/media /app/logs

# 收集静态文件
RUN python manage.py collectstatic --noinput

# 创建非root用户
RUN useradd --create-home --shell /bin/bash app \
    && chown -R app:app /app
USER app

# 暴露端口
EXPOSE 8000

# 健康检查
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/ || exit 1

# 启动命令
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "--timeout", "120", "RecycleTech.wsgi:application"] 