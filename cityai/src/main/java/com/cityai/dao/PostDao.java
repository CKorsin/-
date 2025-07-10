package com.cityai.dao;

import com.cityai.entity.Post;
import com.cityai.util.DBConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    public boolean createPost(Post post) {
        String sql = "INSERT INTO posts (content, user_id, category, title, contact, price, salary, gender, address, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, post.getContent());
            pstmt.setInt(2, post.getUserId());
            pstmt.setString(3, post.getCategory());
            pstmt.setString(4, post.getTitle());
            pstmt.setString(5, post.getContact());
            pstmt.setString(6, post.getPrice());
            pstmt.setString(7, post.getSalary());
            pstmt.setString(8, post.getGender());
            pstmt.setString(9, post.getAddress());
            pstmt.setString(10, post.getImageUrl());
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePost(int postId) {
        String sql = "DELETE FROM posts WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<Post> getAllPosts() {
        return getAllPosts(null);
    }

    public List<Post> getAllPosts(String sortBy) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts ORDER BY ";
        
        // 根据排序参数动态生成ORDER BY子句
        if (sortBy != null) {
            switch (sortBy) {
                case "createTime_asc":
                    sql += "create_time ASC";
                    break;
                case "viewCount_desc":
                    sql += "view_count DESC";
                    break;
                default:
                    sql += "create_time DESC";
            }
        } else {
            sql += "create_time DESC";
        }
        
        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setContent(rs.getString("content"));
                post.setUserId(rs.getInt("user_id"));
                post.setCategory(rs.getString("category"));
                post.setCreateTime(rs.getString("create_time"));
                post.setTitle(rs.getString("title"));
                post.setViewCount(rs.getInt("view_count")); // 添加浏览量字段
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> getPostsByCategory(String category) {
        return getPostsByCategory(category, null);
    }

    public List<Post> getPostsByCategory(String category, String sortBy) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE category = ? ORDER BY ";
        
        // 根据排序参数动态生成ORDER BY子句
        if (sortBy != null) {
            switch (sortBy) {
                case "createTime_asc":
                    sql += "create_time ASC";
                    break;
                case "viewCount_desc":
                    sql += "view_count DESC";
                    break;
                default:
                    sql += "create_time DESC";
            }
        } else {
            sql += "create_time DESC";
        }
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setCreateTime(rs.getString("create_time"));
                    post.setCategory(rs.getString("category"));
                    post.setContact(rs.getString("contact"));
                    post.setPrice(rs.getString("price"));
                    post.setSalary(rs.getString("salary"));
                    post.setGender(rs.getString("gender"));
                    post.setAddress(rs.getString("address"));
                    post.setImageUrl(rs.getString("image_url"));
                    post.setViewCount(rs.getInt("view_count"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> getPostsByUserId(int userId) {
        return getPostsByUserId(userId, null);
    }

    public List<Post> getPostsByUserId(int userId, String sortBy) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE user_id = ? ORDER BY ";
        
        // 根据排序参数动态生成ORDER BY子句
        if (sortBy != null) {
            switch (sortBy) {
                case "createTime_asc":
                    sql += "create_time ASC";
                    break;
                case "viewCount_desc":
                    sql += "view_count DESC";
                    break;
                default:
                    sql += "create_time DESC";
            }
        } else {
            sql += "create_time DESC";
        }
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setCreateTime(rs.getString("create_time"));
                    post.setCategory(rs.getString("category"));
                    post.setContact(rs.getString("contact"));
                    post.setPrice(rs.getString("price"));
                    post.setSalary(rs.getString("salary"));
                    post.setGender(rs.getString("gender"));
                    post.setAddress(rs.getString("address"));
                    post.setImageUrl(rs.getString("image_url"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public void increaseViewCount(int postId) {
        String sql = "UPDATE posts SET view_count = view_count + 1 WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Post getPostById(int postId) {
        String sql = "SELECT p.*, u.username FROM posts p JOIN users u ON p.user_id = u.id WHERE p.id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setContent(rs.getString("content"));
                post.setUserId(rs.getInt("user_id"));
                post.setCategory(rs.getString("category"));
                post.setCreateTime(rs.getString("create_time"));
                post.setTitle(rs.getString("title"));
                post.setContact(rs.getString("contact"));
                post.setPrice(rs.getString("price"));
                post.setSalary(rs.getString("salary"));
                post.setGender(rs.getString("gender"));
                post.setAddress(rs.getString("address"));
                post.setImageUrl(rs.getString("image_url"));
                post.setUsername(rs.getString("username"));
                post.setViewCount(rs.getInt("view_count"));
                return post;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Post> searchPostsByUserId(int userId, String keyword, String sortBy) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE user_id = ? AND (title LIKE ? OR content LIKE ? OR address LIKE ?) ORDER BY ";
        
        // 根据排序参数动态生成ORDER BY子句
        if (sortBy != null) {
            switch (sortBy) {
                case "createTime_asc":
                    sql += "create_time ASC";
                    break;
                case "viewCount_desc":
                    sql += "view_count DESC";
                    break;
                default:
                    sql += "create_time DESC";
            }
        } else {
            sql += "create_time DESC";
        }
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setString(3, "%" + keyword + "%");
            pstmt.setString(4, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setCreateTime(rs.getString("create_time"));
                    post.setCategory(rs.getString("category"));
                    post.setContact(rs.getString("contact"));
                    post.setPrice(rs.getString("price"));
                    post.setSalary(rs.getString("salary"));
                    post.setGender(rs.getString("gender"));
                    post.setAddress(rs.getString("address"));
                    post.setImageUrl(rs.getString("image_url"));
                    post.setViewCount(rs.getInt("view_count"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> searchAllPosts(String keyword, String sortBy) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE title LIKE ? OR content LIKE ? OR address LIKE ? ORDER BY ";
        
        // 根据排序参数动态生成ORDER BY子句
        if (sortBy != null) {
            switch (sortBy) {
                case "createTime_asc":
                    sql += "create_time ASC";
                    break;
                case "viewCount_desc":
                    sql += "view_count DESC";
                    break;
                default:
                    sql += "create_time DESC";
            }
        } else {
            sql += "create_time DESC";
        }
        
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setString(3, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setCreateTime(rs.getString("create_time"));
                    post.setCategory(rs.getString("category"));
                    post.setContact(rs.getString("contact"));
                    post.setPrice(rs.getString("price"));
                    post.setSalary(rs.getString("salary"));
                    post.setGender(rs.getString("gender"));
                    post.setAddress(rs.getString("address"));
                    post.setImageUrl(rs.getString("image_url"));
                    post.setViewCount(rs.getInt("view_count"));
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> searchPosts(String keyword) { 
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE title LIKE ? OR content LIKE ? OR address LIKE ? ORDER BY id DESC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setString(3, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setContent(rs.getString("content"));
                post.setUserId(rs.getInt("user_id"));
                post.setCategory(rs.getString("category"));
                post.setCreateTime(rs.getString("create_time"));
                post.setTitle(rs.getString("title"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public boolean updatePost(Post post) {
        String sql = "UPDATE posts SET title = ?, content = ?, contact = ?, price = ?, salary = ?, gender = ?, address = ?, image_url = ? WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getContact());
            pstmt.setString(4, post.getPrice());
            pstmt.setString(5, post.getSalary());
            pstmt.setString(6, post.getGender());
            pstmt.setString(7, post.getAddress());
            pstmt.setString(8, post.getImageUrl());
            pstmt.setInt(9, post.getId());
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}