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

@WebServlet("/secondhand")
public class SecondhandServlet extends HttpServlet {
    private PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sort = req.getParameter("sort");
        // 获取二手交易分类的帖子并应用排序
        List<Post> posts = postDao.getPostsByCategory("secondhand", sort);
        req.setAttribute("posts", posts);
        req.setAttribute("category", "secondhand");
        req.setAttribute("currentSort", sort);
        // 转发到home.jsp进行渲染
        req.getRequestDispatcher("/WEB-INF/home.jsp").forward(req, resp);
    }
}