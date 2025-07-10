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
    <title>个人主页 - 同城信息平台</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
    <style type="text/tailwindcss">
        @layer utilities {
            .content-auto {
                content-visibility: auto;
            }
            .btn-primary {
                @apply bg-primary text-white px-4 py-2 rounded-lg hover:bg-primary/90 transition-all duration-200 flex items-center justify-center;
            }
            .btn-sm {
                @apply px-3 py-1 text-sm;
            }
            .btn-danger {
                @apply bg-danger text-white px-4 py-2 rounded-lg hover:bg-danger/90 transition-all duration-200 flex items-center justify-center;
            }
            .card-shadow {
                @apply shadow-md hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1;
            }
        }
    </style>
</head>
<body class="font-inter bg-gray-50 text-gray-800 min-h-screen flex flex-col">
    <!-- 顶部导航栏 -->
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
                    <a href="publish.jsp" class="btn-primary btn-sm hidden md:inline-flex items-center">
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

    <!-- 主要内容区 -->
    <main class="flex-grow container mx-auto px-4 py-6">
        <div class="mb-8">
            <h1 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-gray-800 mb-2">我的发布</h1>
            <p class="text-gray-600">管理您发布的所有信息</p>
        </div>

        <!-- 用户名醒目显示 -->
        <div class="bg-primary/5 rounded-xl p-6 mb-8 text-center shadow-md transform transition-all duration-300 hover:shadow-lg">
            <h2 class="text-[clamp(1.8rem,4vw,3rem)] font-bold text-primary mb-2">${sessionScope.user.username}</h2>
            <p class="text-gray-600">您的个人信息中心</p>
        </div>

        <!-- 搜索和排序区域 -->
        <div class="mb-6 flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
            <!-- 搜索表单 -->
            <form action="profile" method="get" class="w-full md:w-auto flex items-center">
                <input type="text" name="keyword" placeholder="搜索我的帖子..." value="${param.keyword}" class="px-4 py-2 border border-gray-300 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-primary/50 w-full md:w-64">
                <button type="submit" class="btn-primary rounded-l-none">
                    <i class="fa fa-search mr-1"></i>搜索
                </button>
            </form>
            <!-- 发布按钮 -->
            <a href="publish.jsp" class="btn-primary btn-sm whitespace-nowrap">
                <i class="fa fa-plus-circle mr-1"></i>发布
            </a>
        </div>
            <!-- 排序下拉菜单 -->
            <form action="profile" method="get" class="w-full md:w-auto flex items-center">
                <input type="hidden" name="keyword" value="${param.keyword}">
                <label for="sort" class="text-gray-600 mr-2">排序方式:</label>
                <select name="sort" id="sort" onchange="this.form.submit()" class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary/50 bg-white">
                    <option value="createTime_desc" ${param.sort == 'createTime_desc' || empty param.sort ? 'selected' : ''}>最新发布</option>
                    <option value="createTime_asc" ${param.sort == 'createTime_asc' ? 'selected' : ''}>最早发布</option>
                    <option value="viewCount_desc" ${param.sort == 'viewCount_desc' ? 'selected' : ''}>最多浏览</option>
                </select>
            </form>
            


        <!-- 帖子列表 -->
        <div class="space-y-4">
            <c:choose>
                <c:when test="${empty posts}">
                    <div class="bg-white rounded-xl shadow-sm p-8 text-center">
                        <i class="fa fa-file-alt text-gray-300 text-5xl mb-4"></i>
                        <h3 class="text-lg font-medium text-gray-700 mb-2">您还没有发布任何信息</h3>
                        <p class="text-gray-500 mb-4">点击上方"发布新信息"按钮开始发布</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${posts}" var="post">
                        <div class="bg-white rounded-xl shadow-sm overflow-hidden card-shadow hover:shadow-lg transition-all duration-300">
                            <div class="p-5">
                                <div class="flex justify-between items-start mb-3">
                                    <div>
                                        <span class="inline-block px-2 py-1 text-xs font-medium bg-primary/10 text-primary rounded-full mb-2">
                                            <c:choose>
                                                <c:when test="${post.category == 'house'}">房屋租售</c:when>
                                                <c:when test="${post.category == 'job'}">招聘求职</c:when>
                                                <c:when test="${post.category == 'secondhand'}">二手市场</c:when>
                                                <c:when test="${post.category == 'dating'}">同城交友</c:when>
                                                <c:when test="${post.category == 'business'}">商家黄页</c:when>
                                                <c:when test="${post.category == 'education'}">教育培训</c:when>
                                                <c:otherwise>${post.category}</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <h2 class="text-xl font-semibold text-gray-800 hover:text-primary transition-colors">
                                            <a href="/cityai-web/post/detail?id=${post.id}&from=profile">${post.title}</a>
                                        </h2>
                                    </div>
                                    <div class="flex space-x-2">
                                        <a href="${pageContext.request.contextPath}/post?action=edit&id=${post.id}" class="btn-primary text-sm px-3 py-1">
                                            <i class="fa fa-edit mr-1"></i>编辑
                                        </a>
                                        <button onclick="confirmDelete('${post.id}')" class="btn-danger text-sm px-3 py-1">
                                            <i class="fa fa-trash-alt mr-1"></i>删除
                                        </button>
                                    </div>
                                </div>
                                <p class="text-gray-600 mb-4 line-clamp-2">${post.content}</p>
                                <div class="flex flex-wrap items-center text-sm text-gray-500 justify-between">
                                    <span><i class="fa fa-clock-o mr-1"></i>${post.createTime}</span>
                                    <c:if test="${not empty post.price}">
                                        <span class="text-accent font-medium ml-4">${post.price}</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- 页脚 -->
     <!-- 页脚 -->
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

    <!-- JavaScript -->
    <script>
        // 删除确认
        function confirmDelete(postId) {
            if (confirm('确定要删除这条信息吗？此操作不可恢复。')) {
                window.location.href = '${pageContext.request.contextPath}/post?action=delete&id=' + postId;
            }
        }
    </script>
</body>
</html>