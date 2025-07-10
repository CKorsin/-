<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #333;
        }
        .login-container {
            background-color: #fff;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            transition: transform 0.3s ease;
        }
        .login-container:hover {
            transform: translateY(-5px);
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: #2c3e50;
            font-size: 1.8rem;
            position: relative;
        }
        .login-container h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            border-radius: 3px;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #555;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 0.9rem 1rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .login-container input[type="text"]:focus,
        .login-container input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }
        .login-container input[type="submit"]:hover {
            background: linear-gradient(90deg, #5a6ee8 0%, #6a4298 100%);
            transform: translateY(-2px);
        }
        .message {
            padding: 0.8rem;
            margin: 1rem 0;
            border-radius: 6px;
            text-align: center;
            font-size: 0.9rem;
        }
        .error {
            background-color: #fff0f0;
            color: #e74c3c;
            border: 1px solid #ffe0e0;
        }
        .success {
            background-color: #f0fff4;
            color: #2ecc71;
            border: 1px solid #e0ffe0;
        }
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.95rem;
        }
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .register-link a:hover {
            color: #556cd6;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>用户登录</h2>
        <% if (request.getAttribute("error") != null) {
            out.println("<div class=\"message error\">" + request.getAttribute("error") + "</div>");
        } %>
        <% if (request.getParameter("registerSuccess") != null) {
            out.println("<div class=\"message success\">注册成功，请登录</div>");
        } %>
        <% if (request.getParameter("logoutSuccess") != null) {
            out.println("<div class=\"message success\">退出登录成功</div>");
        } %>
        <form action="user" method="post">
            <input type="hidden" name="action" value="login">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required>
            </div>
            <input type="submit" value="登录">
        </form>
        <div class="register-link">
            还没有账号？<a href="register.jsp">立即注册</a>
        </div>
    </div>
</body>
</html>