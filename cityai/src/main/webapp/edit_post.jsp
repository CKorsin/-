<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑帖子 - 同城信息平台</title>
    <!-- 引入Tailwind CSS和Font Awesome -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Tailwind配置 -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#165DFF',
                        secondary: '#36CFC9',
                        accent: '#FF7D00',
                        neutral: '#F5F7FA',
                        'neutral-dark': '#4E5969',
                        success: '#00B42A',
                        warning: '#FF7D00',
                        danger: '#F53F3F',
                        'gray-light': '#C9CDD4',
                        'gray-medium': '#86909C',
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <!-- 自定义工具类 -->
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .btn-primary {
                @apply bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition-all duration-200 flex items-center justify-center;
            }
            .btn-danger {
                @apply bg-danger text-white px-4 py-2 rounded-lg hover:bg-danger/90 transition-all duration-200 flex items-center justify-center;
            }
            .form-input {
                @apply w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary/50 focus:border-primary outline-none transition-all;
            }
        }
    </style>
</head>
<body class="font-inter bg-gray-50 text-gray-800 min-h-screen flex flex-col">
    <!-- 顶部导航栏 - 提供网站主导航和用户操作入口 -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4">
            <div class="flex items-center justify-between h-16 md:h-20">
                <!-- Logo区域 - 点击返回首页 -->
                <div class="flex items-center">
                    <a href="home.jsp" class="flex items-center">
                        <i class="fa fa-city text-primary text-2xl mr-2"></i>
                        <span class="text-xl font-bold text-primary">同城信息平台</span>
                    </a>
                </div>

                <!-- 主导航 - 桌面端 - 提供各分类信息入口 -->
                <nav class="hidden md:flex items-center space-x-1">
                    <a href="home.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">首页</a>
                    <a href="house.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">房屋租售</a>
                    <a href="job.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">招聘求职</a>
                    <a href="secondhand.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">二手市场</a>
                    <a href="dating.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">同城交友</a>
                    <a href="business.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">商家黄页</a>
                    <a href="education.jsp" class="px-3 py-2 rounded-md text-sm font-medium text-gray-700 hover:text-primary hover:bg-gray-50">教育培训</a>
                </nav>

                <!-- 用户操作区 - 提供搜索、个人主页和登录/退出功能 -->
                <div class="flex items-center space-x-4">
                    <!-- 搜索框 -->
                    <div class="relative mr-2 hidden md:block">
                        <form action="${pageContext.request.contextPath}/search" method="get" class="relative">
                            <input type="text" name="keyword" placeholder="搜索信息..." class="pl-10 pr-4 py-2 rounded-full border border-gray-300 focus:border-primary focus:ring-2 focus:ring-primary/50 transition-all text-sm w-48 lg:w-64">
                            <button type="submit" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-primary transition-colors">
                                <i class="fa fa-search"></i>
                            </button>
                        </form>
                    </div>
                    <!-- 移动端搜索按钮 -->
                    <button class="p-2 text-gray-500 hover:text-primary transition-colors md:hidden">
                        <i class="fa fa-search text-lg"></i>
                    </button>
                    <c:if test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/profile" class="text-primary font-medium">个人主页</a>
                        <span class="text-gray-600 hidden md:inline">欢迎，<a href="${pageContext.request.contextPath}/profile" class="text-primary hover:underline">${sessionScope.user.username}</a></span>
                        <a href="logout" class="text-gray-600 hover:text-primary">退出</a>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <a href="login.jsp" class="text-gray-600 hover:text-primary">登录</a>
                        <a href="register.jsp" class="btn-primary">注册</a>
                    </c:if>
                </div>
            </div>
        </div>
    </header>

    <!-- 主要内容区 - 编辑帖子表单容器 -->
    <main class="flex-grow container mx-auto px-4 py-6">
        <div class="mb-8">
            <h1 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-2">编辑帖子</h1>
            <p class="text-gray-600">修改您的帖子信息</p>
        </div>

        <!-- 帖子编辑表单卡片 - 包含所有编辑字段和提交按钮 -->
        <div class="bg-white rounded-xl shadow-md p-6 md:p-8 max-w-3xl mx-auto transform transition-all duration-300 hover:shadow-lg">
            <!-- 帖子编辑表单 - 提交修改后的帖子数据到服务器 -->
            <form action="${pageContext.request.contextPath}/post?action=update" method="post" class="space-y-6">
                <input type="hidden" name="id" value="${post.id}">
                <input type="hidden" name="category" value="${post.category}">
                
                <!-- 标题和发布者信息行 - 显示并编辑帖子标题，展示发布者信息 -->
                <div class="space-y-2">
                    <div class="flex justify-between items-center">
                        <label for="title" class="block text-gray-700 font-medium">标题 <span class="text-red-500">*</span></label>
                        <span class="text-sm text-gray-500 bg-gray-100 px-3 py-1 rounded-full">发布者: ${post.username}</span>
                    </div>
                    <input type="text" id="title" name="title" value="${post.title}" class="form-input" required>
                </div>
                
                <!-- 内容区域 - 编辑帖子详细内容 -->
                <div class="space-y-2">
                    <label for="content" class="block text-gray-700 font-medium">详细内容 <span class="text-red-500">*</span></label>
                    <textarea id="content" name="content" rows="8" class="form-input resize-y" required>${post.content}</textarea>
                </div>
                
                <!-- 联系信息和价格 - 编辑联系方式和价格信息 -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="space-y-2">
                        <label for="contact" class="block text-gray-700 font-medium">联系方式 <span class="text-red-500">*</span></label>
                        <input type="text" id="contact" name="contact" value="${post.contact}" class="form-input" required>
                    </div>
                    <div id="generalPriceField" class="space-y-2">
                        <label for="price" class="block text-gray-700 font-medium">价格</label>
                        <input type="text" id="price" name="price" value="${post.price}" class="form-input" placeholder="选填，如：面议、500元/月">
                    </div>
                </div>
                
                <!-- 分类特定字段 - 根据帖子分类动态显示不同的额外字段 -->
                <div id="categoryFields" class="space-y-4 p-4 bg-gray-50 rounded-lg border border-gray-100">
                    <h3 class="text-gray-700 font-medium flex items-center">
                        <i class="fa fa-list-alt text-primary mr-2"></i>分类信息
                    </h3>
                    
                    <!-- 招聘分类字段 - 仅招聘类帖子显示薪资范围 -->
                    <div id="jobFields" class="hidden space-y-4">
                        <div class="space-y-2">
                            <label for="salary" class="block text-gray-700 font-medium">薪资范围 <span class="text-red-500">*</span></label>
                            <input type="text" id="salary" name="salary" value="${post.salary}" class="form-input" placeholder="例如：5000-8000元/月" required>
                        </div>
                    </div>
                    
                    <!-- 交友分类字段 - 仅交友类帖子显示性别选择 -->
                    <div id="datingFields" class="hidden space-y-4">
                        <div class="space-y-2">
                            <label class="block text-gray-700 font-medium">性别 <span class="text-red-500">*</span></label>
                            <div class="flex space-x-6">
                                <label class="inline-flex items-center space-x-2 cursor-pointer">
                                    <input type="radio" name="gender" value="male" class="text-primary focus:ring-primary" ${post.gender == 'male' ? 'checked' : ''}>
                                    <span>男</span>
                                </label>
                                <label class="inline-flex items-center space-x-2 cursor-pointer">
                                    <input type="radio" name="gender" value="female" class="text-primary focus:ring-primary" ${post.gender == 'female' ? 'checked' : ''}>
                                    <span>女</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 商家黄页分类字段 - 仅商家类帖子显示地址信息 -->
                    <div id="businessFields" class="hidden space-y-4">
                        <div class="space-y-2">
                            <label for="address" class="block text-gray-700 font-medium">地址 <span class="text-red-500">*</span></label>
                            <input type="text" id="address" name="address" value="${post.address}" class="form-input" placeholder="请输入商家地址" required>
                        </div>
                    </div>
                </div>
                
                <!-- 操作按钮 - 提供取消和保存修改的功能 -->
                <div class="flex justify-end space-x-4 pt-4 border-t border-gray-100">
                    <a href="${pageContext.request.contextPath}/profile" class="btn-danger px-6">
                        <i class="fa fa-times mr-2"></i>取消
                    </a>
                    <button type="submit" class="btn-primary px-6">
                        <i class="fa fa-save mr-2"></i>保存修改
                    </button>
                </div>
            </form>
        </div>
    </main>

    <!-- 页脚 - 显示网站信息和链接 -->
    <footer class="bg-gradient-to-r from-dark to-gray-800 text-white pt-16 pb-8 mt-16 shadow-lg">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-12">
                <!-- 关于我们 -->
                <div class="transform transition-transform duration-300 hover:translate-y-[-5px]">
                    <h3 class="text-xl font-bold mb-4 flex items-center text-white">
                        <i class="fa fa-map-marker text-primary mr-3 text-2xl"></i>城市通
                    </h3>
                    <p class="text-gray-300 mb-6 leading-relaxed">城市通是一个专注于提供同城生活服务的信息平台，致力于为用户提供便捷、实用的生活信息。</p>
                    <div class="flex space-x-5">
                        <a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 hover:scale-110 transform inline-block">
                            <i class="fa fa-weibo text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 hover:scale-110 transform inline-block">
                            <i class="fa fa-wechat text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 hover:scale-110 transform inline-block">
                            <i class="fa fa-qq text-xl"></i>
                        </a>
                    </div>
                </div>

                <!-- 快速链接 -->
                <div class="transform transition-transform duration-300 hover:translate-y-[-5px]">
                    <h3 class="text-lg font-bold mb-5 text-white border-b border-gray-700 pb-2 inline-block">快速链接</h3>
                    <ul class="space-y-3">
                        <li><a href="${pageContext.request.contextPath}/home.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>首页</a></li>
                        <li><a href="${pageContext.request.contextPath}/house.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>房屋租售</a></li>
                        <li><a href="${pageContext.request.contextPath}/job.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>招聘求职</a></li>
                        <li><a href="${pageContext.request.contextPath}/secondhand.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>二手交易</a></li>
                        <li><a href="${pageContext.request.contextPath}/dating.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>同城交友</a></li>
                        <li><a href="${pageContext.request.contextPath}/business.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>商家黄页</a></li>
                        <li><a href="${pageContext.request.contextPath}/education.jsp" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>教育培训</a></li>
                    </ul>
                </div>

                <!-- 帮助中心 -->
                <div class="transform transition-transform duration-300 hover:translate-y-[-5px]">
                    <h3 class="text-lg font-bold mb-5 text-white border-b border-gray-700 pb-2 inline-block">帮助中心</h3>
                    <ul class="space-y-3">
                        <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>发布指南</a></li>
                        <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>常见问题</a></li>
                        <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>用户协议</a></li>
                        <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>隐私政策</a></li>
                        <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-300 flex items-center"><i class="fa fa-angle-right mr-2 text-primary"></i>联系我们</a></li>
                    </ul>
                </div>

                <!-- 联系我们 -->
                <div class="transform transition-transform duration-300 hover:translate-y-[-5px]">
                    <h3 class="text-lg font-bold mb-5 text-white border-b border-gray-700 pb-2 inline-block">联系我们</h3>
                    <ul class="space-y-4">
                        <li class="flex items-start">
                            <i class="fa fa-map-marker text-primary mt-1 mr-3 text-lg"></i>
                            <span class="text-gray-300">重庆市沙坪坝区大学城南路55号重庆大学虎溪校区</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fa fa-phone text-primary mr-3 text-lg"></i>
                            <span class="text-gray-300">023-65102371</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fa fa-envelope text-primary mr-3 text-lg"></i>
                            <span class="text-gray-300">my.cqu.edu.cn</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fa fa-clock-o text-primary mr-3 text-lg"></i>
                            <span class="text-gray-300">周一至周日 9:00-18:00</span>
                        </li>
                    </ul>
                </div>
            </div>
            <hr class="border-gray-700 mb-8">
            <!-- 版权信息 -->
            <div class="text-center text-gray-400 text-sm">
                <p class="mb-2">© 2025 城市通 版权所有 | CQU备10086号</p>
                <p class="text-xs opacity-70">本网站信息仅供参考，不构成任何交易建议</p>
            </div>
        </div>
    </footer>
    <script>
        // 根据帖子类型显示对应字段
        document.addEventListener('DOMContentLoaded', function() {
            const category = document.querySelector('input[name="category"]').value;
            const jobFields = document.getElementById('jobFields');
            const datingFields = document.getElementById('datingFields');
            const businessFields = document.getElementById('businessFields');
            const generalPriceField = document.getElementById('generalPriceField');
            const priceField = document.getElementById('price');
            const priceLabel = generalPriceField.querySelector('label[for="price"]');
            const salaryField = document.querySelector('input[name="salary"]');
            const genderFields = document.querySelectorAll('input[name="gender"]');
            const addressField = document.querySelector('input[name="address"]');

            // 重置所有字段状态
            [jobFields, datingFields, businessFields, generalPriceField].forEach(el => el.classList.add('hidden'));
            [priceField, salaryField, addressField].forEach(el => el && el.removeAttribute('required'));
            genderFields.forEach(el => el.removeAttribute('required'));
            priceLabel.innerHTML = '价格';

            // 根据分类显示对应字段并设置验证
            switch(category) {
                case 'job':
                    jobFields.classList.remove('hidden');
                    generalPriceField.classList.add('hidden');
                    salaryField.setAttribute('required', 'required');
                    break;
                case 'dating':
                    datingFields.classList.remove('hidden');
                    generalPriceField.classList.add('hidden');
                    genderFields.forEach(el => el.setAttribute('required', 'required'));
                    break;
                case 'business':
                    businessFields.classList.remove('hidden');
                    generalPriceField.classList.add('hidden');
                    addressField.setAttribute('required', 'required');
                    break;
                case 'house':
                case 'secondhand':
                case 'education':
                    generalPriceField.classList.remove('hidden');
                    priceField.setAttribute('required', 'required');
                    priceLabel.innerHTML = '价格 <span class="text-red-500">*</span>';
                    break;
            }
        });
    </script>
</body>
</html>
