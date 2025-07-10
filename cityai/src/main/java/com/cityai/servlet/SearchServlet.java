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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Post> posts = postDao.searchPosts(keyword);
            req.setAttribute("posts", posts);
            req.setAttribute("keyword", keyword);
        }
        req.getRequestDispatcher("search_results.jsp").forward(req, resp);
    }
}