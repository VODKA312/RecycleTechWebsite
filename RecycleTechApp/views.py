from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import render, get_object_or_404
import requests
import base64
from django.http import HttpResponse
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from .models import BlogPost  # 你的文章模型

# Create your views here.
def index(request):
    return render(request, 'index.html')

def about(request):
    return render(request, 'about.html')

def contact(request):
    return render(request, 'contact.html')

def requestquote(request):
    return render(request, 'request-quote.html')

def products(request):
    return render(request, 'project-two.html')


def ourprocess(request):
    return render(request, 'our-process.html')


def companyoverview(request):
    return render(request, 'faq.html')

def national(request):
    return render(request, 'faq_national.html')

def ourfleet(request):
    return render(request, 'faq_our_fleet.html')

def community(request):
    return render(request, 'faq_community.html')

# def blog(request):
#     return render(request, 'blog-grid-two.html')

def blog(request, page=1):
    blog_list = BlogPost.objects.all().order_by('-created_at')  # 这里按创建时间倒序排列
    paginator = Paginator(blog_list, 6)  # 每页显示6篇文章，可修改

    try:
        posts = paginator.page(page)
    except PageNotAnInteger:
        posts = paginator.page(1)
    except EmptyPage:
        posts = paginator.page(paginator.num_pages)

    context = {
        'posts': posts,
        'paginator': paginator,
        'current_page': posts.number,
        'page_range': paginator.get_elided_page_range(number=posts.number, on_each_side=2, on_ends=1),
    }
    return render(request, 'blog-grid-two.html', context)

def blog_content(request, post_id):
    post = get_object_or_404(BlogPost, id=post_id)
    context = {
        'post': post,
    }
    return render(request, 'single-left-sidebar.html', context)

@csrf_exempt
@require_POST
def proxy(request):
    if request.method == 'POST':
        # 从前端获取表单数据
        form_data = request.POST

        # 构建 Mailjet API 请求
        api_url = 'https://api.mailjet.com/v3.1/send'
        api_key = '5e71f0ae515d1ff8d1311023e3970781'
        api_secret = '8676a6d4844f8b136a1eef4ae41eb60f'
        auth = base64.b64encode(f'{api_key}:{api_secret}'.encode()).decode()
        headers = {
            'Content-Type': 'application/json',
            'Authorization': f'Basic {auth}'
        }

        # 获取选择的服务
        service_choice = form_data.get('service')

        # 根据选择的服务设置主题和收件人
        if service_choice == '1':
            subject = 'New request for account inquiry'
            to_email = 'sales@recycletechaustralia.com.au'
        elif service_choice == '2':
            subject = 'New request for Tyre recycling'
            to_email = 'sales@recycletechaustralia.com.au'
        elif service_choice == '3':
            subject = 'New request for Business inquiries'
            to_email = 'Deanh@recycletechaustralia.com.au'
        else:
            subject = 'New request for an unknown service'
            to_email = 'sales@recycletechaustralia.com.au'

        # 构建邮件内容
        text_part = f"User Name: {form_data['name']}\nUser Email: {form_data['email']}\nCompany: {form_data['company']}\nPhone: {form_data['number']}\nMessage: {form_data['message']}"

        data = {
            'Messages': [
                {
                    'From': {
                        'Email': 'kayyitianyang@gmail.com',
                        'Name': 'Kay Yang'
                    },
                    'To': [
                        {
                            'Email': to_email,
                            'Name': 'RecycleTech'
                        }
                    ],
                    'Subject': subject,
                    'TextPart': text_part
                }
            ]
        }

        # 发送 Mailjet API 请求
        response = requests.post(api_url, headers=headers, json=data)

        # 处理 Mailjet API 响应
        if response.status_code == 200:
            return HttpResponse('Quote request submitted successfully!')
        else:
            return HttpResponse('Failed to submit quote request. Please try again later.', status=500)

    return HttpResponse('Invalid request method.', status=400)

