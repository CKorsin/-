<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 销毁当前会话
if (session != null) {
    session.invalidate();
}
// 重定向到首页
response.sendRedirect("home.jsp");
%>