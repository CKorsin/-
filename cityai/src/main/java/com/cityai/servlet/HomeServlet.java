package com.cityai.servlet;

import com.cityai.dao.PostDao;
import com.cityai.entity.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 获取排序参数
            String sort = req.getParameter("sort");
            // 根据排序参数获取帖子
            List<Post> posts = postDao.getAllPosts(sort);
            req.setAttribute("posts", posts);
            req.setAttribute("category", "");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "获取帖子失败: " + e.getMessage());
        }
        
        // 转发到home.jsp
        req.getRequestDispatcher("/WEB-INF/home.jsp").forward(req, resp);
    }
}