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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.UUID;

@WebServlet("/post")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
public class PostServlet extends HttpServlet {
    private final PostDao postDao = new PostDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        if (action == null) {
            resp.sendRedirect("home");
            return;
        }

        switch (action) {
            case "create":
                handleCreatePost(req, resp, user);
                break;
            case "delete":
                handleDeletePost(req, resp, user);
                break;
            case "update":
                handleUpdatePost(req, resp, user);
                break;
            case "edit":
                handleEditPost(req, resp, user);
                break;
            default:
                resp.sendRedirect("home.jsp");
        }
    }

    private void handleCreatePost(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException, ServletException {
        Collection<Part> parts = null;
        // 验证文件数量并获取所有parts
        try {
            parts = req.getParts();
            int fileCount = 0;
            for (Part part : parts) {
                if (part.getContentType() != null) { // 检查是否为文件类型
                    fileCount++;
                    if (fileCount > 1) {
                        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "只允许上传一个文件");
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "文件上传错误");
            return;
        }

        String content = req.getParameter("content");
        String category = req.getParameter("category");
        String title = req.getParameter("title");
        String contact = req.getParameter("contact");
        String price = req.getParameter("price");
        String salary = req.getParameter("salary");
        String gender = req.getParameter("gender");
        String address = req.getParameter("address");

        // 处理图片上传 - 使用已获取的parts
        String imageUrl = "";
        Part imagePart = null;
        try {
            if (parts != null) {
                // 遍历已获取的parts查找image
                for (Part part : parts) {
                    if ("image".equals(part.getName())) {
                        imagePart = part;
                        break;
                    }
                }

                if (imagePart != null && imagePart.getSize() > 0) {
                    String submittedFileName = imagePart.getSubmittedFileName();
                    // 处理可能的空文件名（如文件选择后取消）
                    if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
                        imageUrl = "";
                    } else {
                        // 提取文件名，处理可能包含路径的情况
                        String fileName = submittedFileName.substring(submittedFileName.lastIndexOf(File.separator) + 1);
                        String extension = getFileExtension(fileName);
                        // 如果没有扩展名，默认使用.jpg
                        if (extension.isEmpty()) {
                            extension = ".jpg";
                        }
                        String uuidFileName = UUID.randomUUID().toString() + extension;
                        String savePath = getServletContext().getRealPath("/photo") + File.separator + uuidFileName;
                        new File(getServletContext().getRealPath("/photo")).mkdirs();
                        imagePart.write(savePath);
                        imageUrl = "/photo/" + uuidFileName;
                    }
                } else {
                    imageUrl = "";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "文件上传错误");
            return;
        }

        Post post = new Post(content, user.getId(), category);
        post.setTitle(title);
        post.setContact(contact);
        post.setPrice(price);
        post.setSalary(salary);
        post.setGender(gender);
        post.setAddress(address);
        post.setImageUrl(imageUrl);

        if (postDao.createPost(post)) {
            resp.sendRedirect("home.jsp");
        } else {
            resp.sendRedirect("home.jsp?error=post_create_failed");
        }
    }

    private String getFileExtension(String fileName) {
        if (fileName == null) return "";
        int lastIndexOf = fileName.lastIndexOf('.');
        return lastIndexOf == -1 ? "" : fileName.substring(lastIndexOf);
    }

    private void handleDeletePost(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        int postId = Integer.parseInt(req.getParameter("id"));
        Post post = postDao.getPostById(postId);

        // 检查权限：管理员或帖子所有者
        if (user.getId() != post.getUserId() && user.getId() != 5) {
            resp.sendRedirect("profile?error=permission_denied");
            return;
        }

        if (postDao.deletePost(postId)) {
            resp.sendRedirect("profile");
        } else {
            resp.sendRedirect("profile?error=post_delete_failed");
        }
    }

    private void handleEditPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        int postId = Integer.parseInt(req.getParameter("id"));
        Post post = postDao.getPostById(postId);

        // 检查权限：管理员或帖子所有者
        if (user.getId() != post.getUserId() && user.getId() != 5) {
            resp.sendRedirect("profile?error=permission_denied");
            return;
        }

        req.setAttribute("post", post);
        req.getRequestDispatcher("edit_post.jsp").forward(req, resp);
    }

    private void handleUpdatePost(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                resp.sendRedirect("profile?error=invalid_post_id");
                return;
            }
            
            int postId = Integer.parseInt(idParam);
            Post existingPost = postDao.getPostById(postId);
            
            if (existingPost == null) {
                resp.sendRedirect("profile?error=post_not_found");
                return;
            }

            // 检查权限：管理员或帖子所有者
            if (user.getId() != 5 && existingPost.getUserId() != user.getId()) {
                resp.sendRedirect("profile?error=permission_denied");
                return;
            }

            String title = req.getParameter("title");
            String content = req.getParameter("content");
            String contact = req.getParameter("contact");
            String price = req.getParameter("price");
            String address = req.getParameter("address");
            String salary = req.getParameter("salary");
            String gender = req.getParameter("gender");

            Post post = new Post();
            post.setId(postId);
            post.setTitle(title);
            post.setContent(content);
            post.setContact(contact);
            post.setPrice(price);
            post.setAddress(address);
            post.setSalary(salary);
            post.setGender(gender);
            post.setUserId(existingPost.getUserId()); // 保持原作者ID
            post.setCategory(existingPost.getCategory()); // 保持原分类

            if (postDao.updatePost(post)) {
                resp.sendRedirect("profile?success=post_updated");
            } else {
                resp.sendRedirect("profile?error=post_update_failed");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("profile?error=invalid_post_id");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("profile?error=server_error");
        }
    }
}