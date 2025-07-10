package com.cityai.entity;

/**
 * 帖子实体类，用于封装帖子相关信息
 * 包含帖子的基本属性、分类信息和关联用户信息
 */
public class Post {
    private int viewCount;

    // Getter and Setter
    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }
    /** 帖子唯一标识 */
    private int id;
    /** 帖子内容 */
    private String content;
    /** 发布者用户ID */
    private int userId;
    /** 帖子分类（房屋租售、招聘求职等） */
    private String category;
    /** 发布时间 */
    private String createTime;
    /** 帖子标题 */
    private String title;
    /** 联系方式 */
    private String contact;
    /** 价格信息（适用于二手交易、房屋租售等） */
    private String price;
    /** 薪资范围（适用于招聘类帖子） */
    private String salary;
    /** 性别（适用于交友类帖子） */
    private String gender;
    /** 地址信息（适用于商家黄页等） */
    private String address;
    /** 图片URL */
    private String imageUrl;
    /** 发布者用户名 */
    private String username;

    /**
     * 无参构造函数
     */
    public Post() {
    }

    /**
     * 带参构造函数，初始化帖子内容和用户ID
     * @param content 帖子内容
     * @param userId 发布者用户ID
     */
    public Post(String content, int userId) {
        this.content = content;
        this.userId = userId;
    }

    /**
     * 带参构造函数，初始化帖子内容、用户ID和分类
     * @param content 帖子内容
     * @param userId 发布者用户ID
     * @param category 帖子分类
     */
    public Post(String content, int userId, String category) {
        this.content = content;
        this.userId = userId;
        this.category = category;
    }

    /**
     * 获取帖子ID
     * @return 帖子唯一标识
     */
    public int getId() {
        return id;
    }

    /**
     * 设置帖子ID
     * @param id 帖子唯一标识
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * 获取帖子内容
     * @return 帖子内容文本
     */
    public String getContent() {
        return content;
    }

    /**
     * 设置帖子内容
     * @param content 帖子内容文本
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * 获取发布者用户ID
     * @return 用户ID
     */
    public int getUserId() {
        return userId;
    }

    /**
     * 设置发布者用户ID
     * @param userId 用户ID
     */
    public void setUserId(int userId) {
        this.userId = userId;
    }

    /**
     * 获取帖子分类
     * @return 分类名称
     */
    public String getCategory() {
        return category;
    }

    /**
     * 设置帖子分类
     * @param category 分类名称
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * 获取发布时间
     * @return 发布时间字符串
     */
    public String getCreateTime() {
        return createTime;
    }

    /**
     * 设置发布时间
     * @param createTime 发布时间字符串
     */
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    /**
     * 获取帖子标题
     * @return 标题文本
     */
    public String getTitle() {
        return title;
    }

    /**
     * 设置帖子标题
     * @param title 标题文本
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 获取联系方式
     * @return 联系信息
     */
    public String getContact() {
        return contact;
    }

    /**
     * 设置联系方式
     * @param contact 联系信息
     */
    public void setContact(String contact) {
        this.contact = contact;
    }

    /**
     * 获取价格信息
     * @return 价格文本
     */
    public String getPrice() {
        return price;
    }

    /**
     * 设置价格信息
     * @param price 价格文本
     */
    public void setPrice(String price) {
        this.price = price;
    }

    /**
     * 获取薪资范围
     * @return 薪资文本
     */
    public String getSalary() {
        return salary;
    }

    /**
     * 设置薪资范围
     * @param salary 薪资文本
     */
    public void setSalary(String salary) {
        this.salary = salary;
    }

    /**
     * 获取性别信息
     * @return 性别文本
     */
    public String getGender() {
        return gender;
    }

    /**
     * 设置性别信息
     * @param gender 性别文本
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * 获取地址信息
     * @return 地址文本
     */
    public String getAddress() {
        return address;
    }

    /**
     * 设置地址信息
     * @param address 地址文本
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * 获取图片URL
     * @return 图片地址
     */
    public String getImageUrl() {
        return imageUrl;
    }

    /**
     * 设置图片URL
     * @param imageUrl 图片地址
     */
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    /**
     * 获取发布者用户名
     * @return 用户名
     */
    public String getUsername() { return username; }
    
    /**
     * 设置发布者用户名
     * @param username 用户名
     */
    public void setUsername(String username) { this.username = username; }
}