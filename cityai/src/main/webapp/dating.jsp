<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:forward page="/dating" />

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


</body>
</html>