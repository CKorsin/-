package com.cityai.servlet;

import com.cityai.dao.PostDao;
import com.cityai.entity.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/post/detail")
public class PostDetailServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String postIdStr = req.getParameter("id");
            if (postIdStr == null || postIdStr.isEmpty()) {
                resp.sendRedirect("home.jsp");
                return;
            }

            int postId = Integer.parseInt(postIdStr);
            Post post = postDao.getPostById(postId);
            if (post == null) {
                req.setAttribute("errorMessage", "帖子不存在或已被删除");
            } else {
                postDao.increaseViewCount(postId);
                req.setAttribute("post", post);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "无效的帖子ID");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "获取帖子详情失败: " + e.getMessage());
        }

        req.getRequestDispatcher("/post_detail.jsp").forward(req, resp);
    }
}
