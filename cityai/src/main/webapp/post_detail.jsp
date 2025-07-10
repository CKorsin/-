<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - 城市通</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#165DFF',
                        secondary: '#36CFC9',
                        accent: '#FF7D00',
                        neutral: '#F5F7FA',
                        dark: '#1D2129',
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .btn-primary {
                @apply bg-primary hover:bg-primary/90 text-white font-medium py-2 px-4 rounded-lg transition-all duration-200;
            }
            .btn-secondary {
                @apply bg-white border border-primary text-primary hover:bg-primary/5 font-medium py-2 px-4 rounded-lg transition-all duration-200;
            }
            .nav-link {
                @apply relative px-3 py-2 text-gray-600 hover:text-primary transition-colors duration-200;
            }
            .nav-link::after {
                @apply content-[''] absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-200;
            }
            .nav-link:hover::after {
                @apply w-full;
            }
            .nav-link-active {
                @apply text-primary font-medium;
            }
            .nav-link-active::after {
                @apply w-full;
            }
        }
    </style>
</head>
<body class="font-inter bg-gray-50 text-dark">
    <!-- 顶部导航栏 - 提供网站主导航、城市选择和用户操作功能 -->
    <header class="sticky top-0 z-50 bg-white shadow-sm transition-all duration-300" id="mainHeader">
        <div class="container mx-auto px-4">
            <div class="flex items-center justify-between h-16 md:h-20">
                <!-- Logo区域 - 点击返回首页 -->
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center">
                        <i class="fa fa-map-marker text-primary text-3xl mr-2"></i>
                        <span class="text-xl md:text-2xl font-bold text-primary">城市通</span>
                    </a>
                    
                    <!-- 城市选择区域 -->
                    <div class="ml-6 hidden md:flex items-center">
                        <i class="fa fa-map-marker text-gray-500 mr-1"></i>
                        <span class="font-medium">重庆市</span>
                        <i class="fa fa-angle-down text-gray-400 ml-1"></i>
                    </div>
                </div>
                
                <!-- 主导航菜单 - 桌面版 - 提供各分类信息入口 -->
                <nav class="hidden md:flex items-center space-x-1">
                    <a href="${pageContext.request.contextPath}/home" class="nav-link <c:if test='${empty category}'>nav-link-active</c:if>">首页</a>
                    <a href="${pageContext.request.contextPath}/house?category=house" class="nav-link <c:if test='${category == "house"}'>nav-link-active</c:if>">房屋租售</a>
                    <a href="${pageContext.request.contextPath}/job?category=job" class="nav-link <c:if test='${category == "job"}'>nav-link-active</c:if>">招聘求职</a>
                    <a href="${pageContext.request.contextPath}/secondhand?category=secondhand" class="nav-link <c:if test='${category == "secondhand"}'>nav-link-active</c:if>">二手交易</a>
                    <a href="${pageContext.request.contextPath}/dating?category=dating" class="nav-link <c:if test='${category == "dating"}'>nav-link-active</c:if>">同城交友</a>
                    <a href="${pageContext.request.contextPath}/business?category=business" class="nav-link <c:if test='${category == "business"}'>nav-link-active</c:if>">商家黄页</a>
                    <a href="${pageContext.request.contextPath}/education?category=education" class="nav-link <c:if test='${category == "education"}'>nav-link-active</c:if>">教育培训</a>
                </nav>
                
                <!-- 用户操作区 - 提供搜索、发布信息和登录/注册功能 -->
                <div class="flex items-center">
                    <!-- 搜索框 - 提供信息搜索功能 -->
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
                    
                    <!-- 发布按钮 - 跳转到发布信息页面 -->
                    <a href="${pageContext.request.contextPath}/post" class="btn-primary hidden md:inline-flex items-center">
                        <i class="fa fa-plus-circle mr-1"></i>发布信息
                    </a>
                    
                    
                    <!-- 登录/注册区域 - 提供用户登录和注册入口 -->
                    <div class="ml-4 flex items-center">
                        <c:if test="${empty sessionScope.user}">
                            <a href="login.jsp" class="text-gray-600 hover:text-primary transition-colors mr-3">登录</a>
                            <span class="text-gray-300">|</span>
                            <a href="register.jsp" class="text-gray-600 hover:text-primary transition-colors ml-3">注册</a>
                        </c:if>
                        <c:if test="${not empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/profile" class="text-primary hover:underline mr-3">欢迎, ${sessionScope.user.username}</a>
                            <a href="logout.jsp" class="text-gray-600 hover:text-primary transition-colors">退出登录</a>
                        </c:if>
                    </div>
                    
                        </button>
                </div>
            </div>
        </div>
        

    </header>

    <!-- 主要内容区 - 展示帖子详细信息 -->
    <main class="container mx-auto px-4 py-8">
        <div class="max-w-3xl mx-auto bg-white rounded-xl shadow-sm p-6 md:p-8">
            <!-- 返回按钮 - 返回上一页或帖子列表 -->
            <div class="mb-6">
                <a href="javascript:history.back()" class="btn-secondary inline-flex items-center">
    <i class="fa fa-arrow-left mr-1"></i> 返回列表
</a>
            </div>

            <!-- 帖子详情容器 - 展示帖子完整信息 -->
            <div class="mb-8">
                <!-- 分类标签 - 显示帖子所属分类 -->
                <span class="inline-block bg-primary/10 text-primary text-xs px-3 py-1 rounded-full mb-4">
    <c:choose>
        <c:when test="${post.category == 'house'}">房屋租售</c:when>
        <c:when test="${post.category == 'job'}">招聘求职</c:when>
        <c:when test="${post.category == 'secondhand'}">二手交易</c:when>
        <c:when test="${post.category == 'dating'}">交友</c:when>
        <c:when test="${post.category == 'business'}">商家黄页</c:when>
        <c:when test="${post.category == 'education'}">教育培训</c:when>
        <c:otherwise>${post.category}</c:otherwise>
    </c:choose>
</span>
                
                <!-- 标题和发布者信息 - 显示帖子标题和发布者用户名 -->
                <div class="flex justify-between items-center mb-4">
                    <h1 class="text-2xl md:text-3xl font-bold">${post.title}</h1>
                    <span class="text-primary font-bold text-lg">发布者: ${post.username}</span>
                </div>
                
                <!-- 发布时间信息 - 显示帖子发布时间 -->
                <div class="flex items-center text-gray-500 text-sm mb-6">

                    <span><i class="fa fa-clock-o mr-1"></i> ${post.createTime}</span>
                    <span class="ml-4"><i class="fa fa-eye mr-1"></i> 浏览量: ${post.viewCount}</span>
                </div>
                
                <!-- 帖子内容 - 显示帖子详细内容 -->
                <div class="prose max-w-none text-gray-700 leading-relaxed">
                    ${post.content}
                </div>

                <!-- 帖子图片 - 显示帖子附带图片 -->
                <c:if test="${not empty post.imageUrl}">
                    <div class="mt-6">
                        <img src="${pageContext.request.contextPath}${post.imageUrl}" alt="帖子图片" class="max-w-full rounded-lg shadow-sm">
                    </div>
                </c:if>

                <!-- 分类相关信息 - 根据帖子分类显示特定信息 -->
                <div class="mt-6 space-y-3">
                    <c:if test="${post.category eq 'dating'}">
                        <div class="flex items-center text-gray-600 p-3 bg-gray-50 rounded-lg">
                            <i class="fa fa-venus-mars text-primary mr-3"></i>
                            <span><strong>性别:</strong>
    <c:choose>
        <c:when test="${post.gender == 'male'}">男</c:when>
        <c:when test="${post.gender == 'female'}">女</c:when>
        <c:otherwise>${post.gender}</c:otherwise>
    </c:choose>
</span>
                        </div>
                    </c:if>
                    
                    <c:if test="${post.category eq 'dating' or post.category eq 'secondhand' or post.category eq 'house' or post.category eq 'business' or post.category eq 'job'}">
                        <div class="flex items-center text-gray-600 p-3 bg-gray-50 rounded-lg">
                            <i class="fa fa-phone text-primary mr-3"></i>
                            <span><strong>联系方式:</strong> ${post.contact}</span>
                        </div>
                    </c:if>
                    
                    <c:if test="${post.category eq 'secondhand' or post.category eq 'house'}">
                        <div class="flex items-center text-gray-600 p-3 bg-gray-50 rounded-lg">
                            <i class="fa fa-money text-primary mr-3"></i>
                            <span><strong>价格:</strong> ${post.price}</span>
                        </div>
                    </c:if>
                    
                    <c:if test="${post.category eq 'job'}">
                        <div class="flex items-center text-gray-600 p-3 bg-gray-50 rounded-lg">
                            <i class="fa fa-credit-card text-primary mr-3"></i>
                            <span><strong>薪资:</strong> ${post.salary}</span>
                        </div>
                    </c:if>
                    <c:if test="${post.category eq 'business'}">
                        <div class="flex items-center text-gray-600 p-3 bg-gray-50 rounded-lg">
                            <i class="fa fa-map-marker text-primary mr-3"></i>
                            <span><strong>地址:</strong> ${post.address}</span>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- 操作按钮区域 - 提供点赞、分享和收藏功能 -->
            <div class="flex justify-between pt-6 border-t border-gray-100">
                <button class="text-gray-500 hover:text-primary transition-colors flex items-center">
                    <i class="fa fa-thumbs-up mr-1"></i> 点赞
                </button>
                <div class="space-x-3">
                    <button class="text-gray-500 hover:text-primary transition-colors">
                        <i class="fa fa-share-alt"></i>
                    </button>
                    <button class="text-gray-500 hover:text-primary transition-colors">
                        <i class="fa fa-bookmark-o"></i>
                    </button>
                </div>
            </div>
        </div>
    </main>

    <!-- 页脚 - 显示网站信息、快速链接和联系方式 -->
    <footer class="bg-dark text-white pt-12 pb-6 mt-12">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
                <!-- 关于我们 - 显示网站简介 -->
                <div>
                    <h3 class="text-lg font-bold mb-4 flex items-center">
                        <i class="fa fa-map-marker text-primary mr-2"></i>城市通
                    </h3>
                    <p class="text-gray-400 mb-4">城市通是一个专注于提供同城生活服务的信息平台，致力于为用户提供便捷、实用的生活信息。</p>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-white transition-colors">
                            <i class="fa fa-weibo"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors">
                            <i class="fa fa-wechat"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors">
                            <i class="fa fa-qq"></i>
                        </a>
                    </div>
                </div>
                
                <!-- 快速链接 - 提供主要页面导航链接 -->
                <div>
                    <h3 class="text-lg font-bold mb-4">快速链接</h3>
                    <ul class="space-y-2">
                        <li><a href="/home.jsp" class="text-gray-400 hover:text-white transition-colors">首页</a></li>
                        <li><a href="/house.jsp" class="text-gray-400 hover:text-white transition-colors">房屋租售</a></li>
                        <li><a href="/job.jsp" class="text-gray-400 hover:text-white transition-colors">招聘求职</a></li>
                        <li><a href="/secondhand.jsp" class="text-gray-400 hover:text-white transition-colors">二手交易</a></li>
                        <li><a href="/dating.jsp" class="text-gray-400 hover:text-white transition-colors">同城交友</a></li>
                        <li><a href="/business.jsp" class="text-gray-400 hover:text-white transition-colors">商家黄页</a></li>
                        <li><a href="/education.jsp" class="text-gray-400 hover:text-white transition-colors">教育培训</a></li>
                    </ul>
                </div>
                
                <!-- 帮助中心 - 提供用户帮助相关链接 -->
                <div>
                    <h3 class="text-lg font-bold mb-4">帮助中心</h3>
                    <ul class="space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-white transition-colors">发布指南</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition-colors">常见问题</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition-colors">用户协议</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition-colors">隐私政策</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition-colors">联系我们</a></li>
                    </ul>
                </div>
                
                <!-- 联系我们 - 显示联系地址和方式 -->
                <div>
                    <h3 class="text-lg font-bold mb-4">联系我们</h3>
                    <ul class="space-y-3">
                        <li class="flex items-start">
                            <i class="fa fa-map-marker text-primary mt-1 mr-3"></i>
                            <span class="text-gray-400">重庆市沙坪坝区大学城南路55号重庆大学虎溪校区</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fa fa-phone text-primary mr-3"></i>
                            <span class="text-gray-400">023-65102371</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fa fa-envelope text-primary mr-3"></i>
                            <span class="text-gray-400">my.cqu.edu.cn</span>
                        </li>
                        <li class="flex items-center">
                            <i class="fa fa-clock-o text-primary mr-3"></i>
                            <span class="text-gray-400">周一至周日 9:00-18:00</span>
                        </li>
                    </ul>
                </div>
            </div>
            
            <hr class="border-gray-800 mb-6">
            
            <!-- 版权信息 -->
            <div class="text-center text-gray-500 text-sm">
                <p>© 2025 城市通 版权所有 | CQU备10086号</p>
            </div>
        </div>
    </footer>
</body>
</html>