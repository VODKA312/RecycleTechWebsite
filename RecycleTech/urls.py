"""RecycleTech URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from RecycleTechApp.views import index, about, contact, requestquote, proxy, blog, blog_content, products, ourprocess, companyoverview, national, ourfleet, community
from django.conf import settings
from django.conf.urls. static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index, name='index'),
    path('about', about, name='about'),
    path('blog', blog, name='blog'),
    path('blog/<int:post_id>/', blog_content, name='blog_content'),
    path('products', products, name='products'),
    path('ourprocess', ourprocess, name='ourprocess'),
    path('contact', contact, name='contact'),
    path('proxy/', proxy, name='proxy'),
    path('requestquote', requestquote, name="requestquote"),
    path('companyoverview', companyoverview, name="companyoverview"),
    path('national', national, name="national"),
    path('ourfleet', ourfleet, name="ourfleet"),
    path('community', community, name="community"),
    path('blog/page/<int:page>/', blog_content, name='blog_page'),
]+ static (settings.STATIC_URL, document_root = settings.STATIC_ROOT)
