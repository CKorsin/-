<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:forward page="/house" />





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
                        <li><a href="/home.jsp" class="text-gray-400 hover:text-white transition-colors">首页</a></li>
                        <li><a href="/house.jsp" class="text-gray-400 hover:text-white transition-colors">房屋租售</a></li>
                        <li><a href="/job.jsp" class="text-gray-400 hover:text-white transition-colors">招聘求职</a></li>
                        <li><a href="/secondhand.jsp" class="text-gray-400 hover:text-white transition-colors">二手交易</a></li>
                        <li><a href="/dating.jsp" class="text-gray-400 hover:text-white transition-colors">同城交友</a></li>
                        <li><a href="/business.jsp" class="text-gray-400 hover:text-white transition-colors">商家黄页</a></li>
                        <li><a href="/education.jsp" class="text-gray-400 hover:text-white transition-colors">教育培训</a></li>
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
