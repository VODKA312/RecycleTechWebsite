"""
Production settings for RecycleTech project.
This file contains all production environment configurations.
"""

import os
import sys
from pathlib import Path

# 添加项目根目录到Python路径
BASE_DIR = Path(__file__).resolve().parent.parent
sys.path.append(str(BASE_DIR))

# 导入基础设置
from RecycleTech.settings import *

# 生产环境设置
DEBUG = False

# 允许的主机
ALLOWED_HOSTS = [
    'localhost',
    '127.0.0.1',
    '0.0.0.0',
    '*',  # 生产环境请限制为具体域名
]

# 安全设置
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
X_FRAME_OPTIONS = 'DENY'

# 静态文件设置
STATIC_ROOT = '/app/staticfiles/'
STATIC_URL = '/static/'

# 媒体文件设置
MEDIA_URL = '/media/'
MEDIA_ROOT = '/app/media/'

# 数据库设置
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '/app/db.sqlite3',
    }
}

# 日志设置
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'root': {
        'handlers': ['console'],
        'level': 'INFO',
    },
}

# 缓存设置
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    }
} 