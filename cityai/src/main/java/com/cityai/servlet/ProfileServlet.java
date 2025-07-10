package com.cityai.servlet;

import com.cityai.dao.PostDao;
import com.cityai.entity.Post;
import com.cityai.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String sort = req.getParameter("sort");
        String keyword = req.getParameter("keyword");
        List<Post> posts;
        // 管理员可以查看所有帖子
        if (user.getId() == 5) {
            if (keyword != null && !keyword.isEmpty()) {
                posts = postDao.searchAllPosts(keyword, sort);
            } else {
                posts = postDao.getAllPosts(sort);
            }
        } else {
            if (keyword != null && !keyword.isEmpty()) {
                posts = postDao.searchPostsByUserId(user.getId(), keyword, sort);
            } else {
                posts = postDao.getPostsByUserId(user.getId(), sort);
            }
        }

        req.setAttribute("posts", posts);
        req.setAttribute("category", "profile");
        req.setAttribute("username", user.getUsername());
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}