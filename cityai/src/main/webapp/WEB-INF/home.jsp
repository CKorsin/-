<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>城市通 - 同城信息网</title>
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
            .card-hover {
                @apply transition-all duration-300 hover:shadow-lg hover:-translate-y-1;
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
            .scrollbar-hide::-webkit-scrollbar {
                display: none;
            }
            .scrollbar-hide {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
        }
    </style>
</head>
<body class="font-inter bg-gray-50 text-dark">
    <!-- 顶部导航 -->
    <header class="sticky top-0 z-50 bg-white shadow-sm transition-all duration-300" id="mainHeader">
        <div class="container mx-auto px-4">
            <div class="flex items-center justify-between h-16 md:h-20">
                <!-- Logo -->
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/home" class="flex items-center">
                        <i class="fa fa-map-marker text-primary text-3xl mr-2"></i>
                        <span class="text-xl md:text-2xl font-bold text-primary">城市通</span>
                    </a>
                    
                    <!-- 城市选择 -->
                    <div class="ml-6 hidden md:flex items-center">
                        <i class="fa fa-map-marker text-gray-500 mr-1"></i>
                        <span class="font-medium">重庆市</span>
                        <i class="fa fa-angle-down text-gray-400 ml-1"></i>
                    </div>
                </div>
                
                <!-- 主导航 - 桌面版 -->
                <nav class="hidden md:flex items-center space-x-1">
                    <a href="${pageContext.request.contextPath}/home" class="nav-link <c:if test='${empty category}'>nav-link-active</c:if>">首页</a>
                    <a href="${pageContext.request.contextPath}/house?category=house" class="nav-link <c:if test='${category == "house"}'>nav-link-active</c:if>">房屋租售</a>
                    <a href="${pageContext.request.contextPath}/job?category=job" class="nav-link <c:if test='${category == "job"}'>nav-link-active</c:if>">招聘求职</a>
                    <a href="${pageContext.request.contextPath}/secondhand?category=secondhand" class="nav-link <c:if test='${category == "secondhand"}'>nav-link-active</c:if>">二手交易</a>
                    <a href="${pageContext.request.contextPath}/dating?category=dating" class="nav-link <c:if test='${category == "dating"}'>nav-link-active</c:if>">同城交友</a>
                    <a href="${pageContext.request.contextPath}/business?category=business" class="nav-link <c:if test='${category == "business"}'>nav-link-active</c:if>">商家黄页</a>
                    <a href="${pageContext.request.contextPath}/education?category=education" class="nav-link <c:if test='${category == "education"}'>nav-link-active</c:if>">教育培训</a>
                </nav>
                
                <!-- 用户操作 -->
                <div class="flex items-center">
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
                    
                    <!-- 发布按钮 -->
                    <a href="publish.jsp" class="btn-primary hidden md:inline-flex items-center">
                        <i class="fa fa-plus-circle mr-1"></i>发布信息
                    </a>
                    
                    
                    <!-- 登录/注册 -->
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

    <!-- 主要内容 -->
    <main class="container mx-auto px-4 py-6">
        <!-- 帖子列表模块 -->
        <section class="mb-12">
            <div class="mb-6">
    <div class="flex items-center justify-between">
        <h2 class="text-2xl font-bold text-dark">
            <c:choose>
                <c:when test="${param.category == 'house'}">房屋租售</c:when>
                <c:when test="${param.category == 'job'}">招聘求职</c:when>
                <c:when test="${param.category == 'secondhand'}">二手交易</c:when>
                <c:when test="${param.category == 'dating'}">同城交友</c:when>
                <c:when test="${param.category == 'business'}">商家黄页</c:when>
                <c:when test="${param.category == 'education'}">教育培训</c:when>
                <c:otherwise>最新发布</c:otherwise>
            </c:choose>
        </h2>
        <a href="publish.jsp" class="text-primary hover:text-primary/80 flex items-center">
            <i class="fa fa-pencil mr-1"></i> 发布新帖
        </a>
    </div>
    </p>
    
    <!-- 排序选项 -->
    <div class="mt-4 flex items-center">
        <form action="${pageContext.request.contextPath}/${empty category ? 'home' : category}" method="get" class="flex items-center">
            <input type="hidden" name="category" value="${param.category}">
            <label class="text-gray-600 mr-2">排序方式:</label>
            <select name="sort" onchange="this.form.submit()" class="border border-gray-300 rounded-md px-3 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-primary/50">
                <option value="createTime_desc" ${param.sort == 'createTime_desc' || empty param.sort ? 'selected' : ''}>最新发布</option>
                <option value="createTime_asc" ${param.sort == 'createTime_asc' ? 'selected' : ''}>最早发布</option>
                <option value="viewCount_desc" ${param.sort == 'viewCount_desc' ? 'selected' : ''}>浏览最多</option>
            </select>
        </form>
    </div>
</div>

            <!-- 帖子列表 -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="post" items="${posts}">
                    <a href="/cityai-web/post/detail?id=${post.id}&from=home" class="block">
                        <div class="bg-white rounded-xl shadow-sm p-5 card-hover h-full flex flex-col">
                            <!-- 帖子标题 -->
                            <h3 class="text-lg font-semibold mb-2 line-clamp-2" title="${post.title}">${post.title}</h3>

                            <div class="mt-auto flex items-center justify-between pt-4 border-t border-gray-100">
                                <!-- 分类标签 -->
                                <span class="inline-block bg-primary/10 text-primary text-xs px-2 py-1 rounded-full">
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
                                <div class="flex items-center space-x-4">
                                    <!-- 发布日期 -->
                                    <span class="text-gray-500 text-sm">${post.createTime}</span>
                                    <!-- 浏览量 -->
                                    <span class="text-gray-500 text-xs flex items-center">
                                        <i class="fa fa-eye mr-1"></i> ${post.viewCount}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>

                <!-- 无帖子时显示 -->
                <c:if test="${empty posts}">
                    <div class="col-span-full py-12 text-center">
                        <i class="fa fa-file-text-o text-4xl text-gray-300 mb-3"></i>
                        <p class="text-gray-500">暂无发布的帖子</p>
                    </div>
                </c:if>
            </div>
        </section>
    </main>

    <!-- 页脚 -->
    <footer class="bg-dark text-white pt-12 pb-6 mt-12">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-8">
                <!-- 关于我们 -->
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
                
                <!-- 快速链接 -->
                <div>
                    <h3 class="text-lg font-bold mb-4">快速链接</h3>
                    <ul class="space-y-2">
                        <li><a href="home.jsp" class="text-gray-400 hover:text-white transition-colors">首页</a></li>
                        <li><a href="house.jsp" class="text-gray-400 hover:text-white transition-colors">房屋租售</a></li>
                        <li><a href="job.jsp" class="text-gray-400 hover:text-white transition-colors">招聘求职</a></li>
                        <li><a href="secondhand.jsp" class="text-gray-400 hover:text-white transition-colors">二手交易</a></li>
                        <li><a href="dating.jsp" class="text-gray-400 hover:text-white transition-colors">同城交友</a></li>
                        <li><a href="business.jsp" class="text-gray-400 hover:text-white transition-colors">商家黄页</a></li>
                        <li><a href="education.jsp" class="text-gray-400 hover:text-white transition-colors">教育培训</a></li>
                    </ul>
                </div>
                
                <!-- 帮助中心 -->
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
                
                <!-- 联系我们 -->
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