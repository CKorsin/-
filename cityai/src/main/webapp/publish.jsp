<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp" />
</c:if>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布信息 - 城市通</title>
    <script src="https://cdn.tailwindcss.com"></script>

<script>
function checkFileUpload(form) {
    const fileInput = form.querySelector('input[type="file"]');
    if (!fileInput.files || fileInput.files.length === 0) {
        form.enctype = 'application/x-www-form-urlencoded';
        fileInput.removeAttribute('name'); // 移除name属性避免空文件字段提交
    } else {
        form.enctype = 'multipart/form-data';
        fileInput.setAttribute('name', 'image'); // 恢复name属性
    }
    return true;
}
</script>
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
            .nav-link {
                @apply relative px-3 py-2 text-sm font-medium text-gray-600 hover:text-primary transition-colors after:absolute after:bottom-0 after:left-0 after:h-0.5 after:w-0 after:bg-primary after:transition-all after:duration-200;
            }
            .nav-link-active {
                @apply text-primary font-medium;
            }
            .nav-link-active::after {
                @apply w-full;
            }
        }
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
        }
    </style>
</head>
<body class="font-inter bg-gray-50 text-dark">
    <!-- 登录检查 -->
    <c:if test="${empty sessionScope.user}">
        <script type="text/javascript">
            alert('请先登录后发布信息');
            window.location.href = 'login.jsp';
        </script>
    </c:if>

    <!-- 顶部导航 -->
    <header class="sticky top-0 z-50 bg-white shadow-sm transition-all duration-300" id="mainHeader">
    <div class="container mx-auto px-4">
        <div class="flex items-center justify-between h-16 md:h-20">
            <!-- Logo -->
            <div class="flex items-center">
                <a href="home.jsp" class="flex items-center">
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
                <a href="${pageContext.request.contextPath}/home.jsp" class="nav-link">首页</a>
                <a href="${pageContext.request.contextPath}/house.jsp" class="nav-link">房屋租售</a>
                <a href="${pageContext.request.contextPath}/job.jsp" class="nav-link">招聘求职</a>
                <a href="${pageContext.request.contextPath}/secondhand.jsp" class="nav-link">二手交易</a>
                <a href="${pageContext.request.contextPath}/dating.jsp" class="nav-link">同城交友</a>
                <a href="${pageContext.request.contextPath}/business.jsp" class="nav-link">商家黄页</a>
                <a href="${pageContext.request.contextPath}/education.jsp" class="nav-link">教育培训</a>
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
                <a href="${pageContext.request.contextPath}/publish.jsp" class="btn-primary hidden md:block">
                    <i class="fa fa-plus mr-1"></i> 发布
                </a>
                
                <!-- 移动端菜单按钮 -->
                <button class="md:hidden p-2 rounded-lg hover:bg-gray-100 transition-colors" id="mobileMenuBtn">
                    <i class="fa fa-bars text-gray-600"></i>
                </button>
                
                <!-- 用户登录/注册区域 -->
                <div class="ml-4 relative" id="userMenuContainer">
                    <!-- 用户信息显示 -->
                    <c:if test="${not empty sessionScope.user}">
                        <div class="flex items-center space-x-2 cursor-pointer" id="userMenuBtn">
                            <span class="hidden sm:inline text-sm font-medium">${sessionScope.user.username}</span>
                            <i class="fa fa-angle-down text-gray-400 text-xs"></i>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</header>

    <!-- 主要内容 -->
    <main class="container mx-auto px-4 py-8 max-w-3xl">
        <h1 class="text-2xl font-bold text-gray-800 mb-6">发布信息</h1>

        <div class="bg-white rounded-xl shadow-sm p-6">
            <form action="${pageContext.request.contextPath}/post" method="post" enctype="multipart/form-data" class="space-y-6" onsubmit="return checkFileUpload(this);">
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="userId" value="${sessionScope.user.id}">

                <div>
                    <label for="category" class="block text-sm font-medium text-gray-700 mb-1">选择分类 <span class="text-red-500">*</span></label>
                    <select name="category" id="category" required class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                        <option value="">请选择分类</option>
                        <option value="house">房屋租售</option>
                        <option value="job">招聘求职</option>
                        <option value="secondhand">二手交易</option>
                        <option value="dating">同城交友</option>
                        <option value="business">商家黄页</option>
                        <option value="education">教育培训</option>
                    </select>
                </div>

                <div>
                    <label for="title" class="block text-sm font-medium text-gray-700 mb-1">标题 <span class="text-red-500">*</span></label>
                    <input type="text" name="title" id="title" placeholder="请输入标题" required class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                </div>

                <div>
                    <label for="content" class="block text-sm font-medium text-gray-700 mb-1">详细内容 <span class="text-red-500">*</span></label>
                    <textarea name="content" id="content" rows="6" placeholder="请详细描述您的信息..." required class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"></textarea>
                </div>

                <!-- 图片上传 -->
                <div>
                    <label for="image" class="block text-sm font-medium text-gray-700 mb-1">上传图片</label>
                    <input type="file" name="image" id="image" accept="image/*" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                </div>

                <!-- 分类特定字段 -->
                <div id="categoryFields" class="space-y-4 mt-4">
                    <!-- 招聘分类字段 -->
                    <div id="jobFields" class="hidden space-y-4">
                        <div>
                            <label for="salary" class="block text-sm font-medium text-gray-700 mb-1">薪资范围 <span class="text-red-500">*</span></label>
                            <input type="text" name="salary" id="salary" placeholder="例如：5000-8000元/月" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                        </div>
                    </div>
                    
                    <!-- 交友分类字段 -->
                    <div id="datingFields" class="hidden space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">性别 <span class="text-red-500">*</span></label>
                            <div class="flex space-x-4">
                                <label class="inline-flex items-center">
                                    <input type="radio" name="gender" value="male" class="mr-2"> 男
                                </label>
                                <label class="inline-flex items-center">
                                    <input type="radio" name="gender" value="female" class="mr-2"> 女
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 商家黄页分类字段 -->
                    <div id="businessFields" class="hidden space-y-4">
                        <div>
                            <label for="address" class="block text-sm font-medium text-gray-700 mb-1">地址 <span class="text-red-500">*</span></label>
                            <input type="text" name="address" id="address" placeholder="请输入商家地址" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                        </div>
                    </div>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="contact" class="block text-sm font-medium text-gray-700 mb-1">联系方式 <span class="text-red-500">*</span></label>
                        <input type="text" name="contact" id="contact" placeholder="请输入电话或微信" required class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                    </div>
                    <div id="generalPriceField">
                        <label for="price" class="block text-sm font-medium text-gray-700 mb-1">价格</label>
                        <input type="text" name="price" id="price" placeholder="如：5000元/月 或 面议" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                    </div>
                </div>

                <div class="flex justify-end space-x-3 pt-4 border-t">
                    <a href="javascript:history.back()" class="btn-secondary">取消</a>
                    <button type="submit" class="btn-primary">
                        <i class="fa fa-paper-plane mr-1"></i>发布信息
                    </button>
                </div>
            </form>

<script>
// 统一处理分类字段显示/隐藏和验证
document.getElementById('category').addEventListener('change', function() {
    const category = this.value;
    const jobFields = document.getElementById('jobFields');
    const datingFields = document.getElementById('datingFields');
    const businessFields = document.getElementById('businessFields');
    const priceContainer = document.getElementById('generalPriceField');
    const priceField = document.getElementById('price');
    const priceLabel = priceContainer.querySelector('label');
    const salaryField = document.querySelector('input[name="salary"]');
    const genderFields = document.querySelectorAll('input[name="gender"]');
    const addressField = document.getElementById('address');
    
    // 重置所有字段状态
    [jobFields, datingFields, businessFields, priceContainer].forEach(el => el.classList.add('hidden'));
    [priceField, salaryField, addressField].forEach(el => el && el.removeAttribute('required'));
    genderFields.forEach(el => el.removeAttribute('required'));
    priceLabel.innerHTML = '价格';
    
    // 根据分类显示对应字段并设置验证
    switch(category) {
        case 'job':
            jobFields.classList.remove('hidden');
            salaryField.setAttribute('required', 'required');
            priceContainer.classList.add('hidden');
            break;
        case 'dating':
            datingFields.classList.remove('hidden');
            genderFields.forEach(el => el.setAttribute('required', 'required'));
            priceContainer.classList.add('hidden'); // 隐藏价格字段
            priceField.disabled = true;
            break;
        case 'business':
            businessFields.classList.remove('hidden');
            addressField.setAttribute('required', 'required');
            priceContainer.classList.add('hidden');
            break;
        case 'house':
        case 'secondhand':
        case 'education':
            priceContainer.classList.remove('hidden');
                        priceField.setAttribute('required', 'required');
                        priceLabel.innerHTML = '价格 <span class="text-red-500">*</span>';
                        break;
                }
            });
        </script>
    </div>
    </main>


</body>
</html>