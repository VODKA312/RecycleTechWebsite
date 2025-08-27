"""
生产环境配置文件
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
    'your-domain.com',
    'www.your-domain.com',
    'your-server-ip',
    'localhost',
]

# 安全设置
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
X_FRAME_OPTIONS = 'DENY'

# 静态文件设置
STATIC_ROOT = '/var/www/recycletech/staticfiles/'
STATIC_URL = '/static/'

# 媒体文件设置
MEDIA_URL = '/media/'
MEDIA_ROOT = '/var/www/recycletech/media/'

# 数据库设置（生产环境建议使用PostgreSQL或MySQL）
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '/var/www/recycletech/db.sqlite3',
    }
}

# 日志设置
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filename': '/var/log/recycletech/django.log',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['file'],
            'level': 'INFO',
            'propagate': True,
        },
    },
}

# 缓存设置
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    }
} 