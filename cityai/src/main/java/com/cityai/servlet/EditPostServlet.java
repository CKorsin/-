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

@WebServlet("/editPost")
public class EditPostServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            String postIdStr = req.getParameter("id");
            if (postIdStr == null || postIdStr.isEmpty()) {
                resp.sendRedirect("profile.jsp");
                return;
            }

            int postId = Integer.parseInt(postIdStr);
            Post post = postDao.getPostById(postId);

            if (post == null || post.getUserId() != user.getId()) {
                req.setAttribute("errorMessage", "无法找到该帖子");
                req.getRequestDispatcher("profile.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("post", post);
            req.getRequestDispatcher("edit_post.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "无效的帖子ID");
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            int postId = Integer.parseInt(req.getParameter("id"));
            Post post = postDao.getPostById(postId);

            // 验证帖子所有权
            if (post == null || post.getUserId() != user.getId()) {
                req.setAttribute("errorMessage", "无法编辑此帖子");
                req.getRequestDispatcher("profile.jsp").forward(req, resp);
                return;
            }

            // 更新帖子信息
            post.setTitle(req.getParameter("title"));
            post.setContent(req.getParameter("content"));
            post.setContact(req.getParameter("contact"));
            post.setPrice(req.getParameter("price"));
            post.setAddress(req.getParameter("address"));

            if (postDao.updatePost(post)) {
                resp.sendRedirect("profile.jsp?updateSuccess=true");
            } else {
                req.setAttribute("errorMessage", "更新帖子失败");
                req.getRequestDispatcher("edit_post.jsp?id=" + postId).forward(req, resp);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "无效的帖子ID");
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        }
    }
}