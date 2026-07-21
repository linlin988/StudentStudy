-- 1. 创建数据库
CREATE DATABASE IF NOT EXISTS student_study
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE student_study;

-- =============================================
-- 模块1：用户与权限模块
-- =============================================
-- 1.1 用户表
DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
                          username VARCHAR(32) NOT NULL COMMENT '用户名',
                          password VARCHAR(100) NOT NULL COMMENT '加密后的密码',
                          phone VARCHAR(11) COMMENT '手机号',
                          gender TINYINT DEFAULT 0 COMMENT '性别 0未知 1男 2女',
                          age INT COMMENT '年龄',
                          avatar VARCHAR(255) COMMENT '头像URL',
                          avatar_status TINYINT DEFAULT 1 COMMENT '头像审核状态 0待审核 1正常 2违规',
                          qq VARCHAR(20) COMMENT 'QQ号',
                          wechat VARCHAR(50) COMMENT '微信号',
                          status TINYINT DEFAULT 1 COMMENT '账号状态 0禁用 1正常',
                          create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                          deleted TINYINT DEFAULT 0 COMMENT '逻辑删除 0未删除 1已删除',
                          UNIQUE KEY uk_username (username),
                          UNIQUE KEY uk_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 1.2 角色表
DROP TABLE IF EXISTS sys_role;
CREATE TABLE sys_role (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '角色ID',
                          role_name VARCHAR(32) NOT NULL COMMENT '角色名称',
                          role_code VARCHAR(32) NOT NULL COMMENT '角色编码',
                          description VARCHAR(255) COMMENT '角色描述',
                          create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          UNIQUE KEY uk_role_code (role_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- 1.3 用户-角色关联表（多对多）
DROP TABLE IF EXISTS sys_user_role;
CREATE TABLE sys_user_role (
                               id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               user_id BIGINT NOT NULL COMMENT '用户ID',
                               role_id BIGINT NOT NULL COMMENT '角色ID',
                               create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               UNIQUE KEY uk_user_role (user_id, role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户角色关联表';

-- =============================================
-- 模块2：期末智能刷题系统
-- =============================================
-- 2.1 题库表
DROP TABLE IF EXISTS question_bank;
CREATE TABLE question_bank (
                               id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '题库ID',
                               bank_name VARCHAR(100) NOT NULL COMMENT '题库名称',
                               description VARCHAR(500) COMMENT '题库描述',
                               create_user_id BIGINT COMMENT '创建人ID',
                               question_count INT DEFAULT 0 COMMENT '题目总数',
                               create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                               update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               deleted TINYINT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题库表';

-- 2.2 题目表
DROP TABLE IF EXISTS question;
CREATE TABLE question (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '题目ID',
                          bank_id BIGINT NOT NULL COMMENT '所属题库ID',
                          question_type TINYINT NOT NULL DEFAULT 1 COMMENT '题目类型 1单选 2多选 3判断',
                          question_content TEXT NOT NULL COMMENT '题目内容',
                          options JSON COMMENT '选项内容（JSON格式：{"A":"选项1","B":"选项2"}）',
                          correct_answer VARCHAR(50) NOT NULL COMMENT '正确答案',
                          analysis TEXT COMMENT '答案解析',
                          create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                          update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          deleted TINYINT DEFAULT 0,
                          INDEX idx_bank_id (bank_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题目表';

-- 2.3 练习记录表
DROP TABLE IF EXISTS practice_record;
CREATE TABLE practice_record (
                                 id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '练习记录ID',
                                 user_id BIGINT NOT NULL COMMENT '用户ID',
                                 bank_id BIGINT NOT NULL COMMENT '练习题库ID',
                                 total_count INT NOT NULL COMMENT '本次练习题目总数',
                                 correct_count INT NOT NULL COMMENT '正确数量',
                                 accuracy DECIMAL(5,2) COMMENT '正确率（百分比）',
                                 start_time DATETIME COMMENT '开始时间',
                                 end_time DATETIME COMMENT '结束时间',
                                 create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                                 INDEX idx_user_id (user_id),
                                 INDEX idx_bank_id (bank_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='练习记录表';

-- 2.4 练习题目明细表
DROP TABLE IF EXISTS practice_question_detail;
CREATE TABLE practice_question_detail (
                                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                          record_id BIGINT NOT NULL COMMENT '练习记录ID',
                                          question_id BIGINT NOT NULL COMMENT '题目ID',
                                          user_answer VARCHAR(50) COMMENT '用户作答答案',
                                          is_correct TINYINT COMMENT '是否正确 0错误 1正确',
                                          create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                                          INDEX idx_record_id (record_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='练习题目明细表';

-- 2.5 错题本表
DROP TABLE IF EXISTS wrong_question;
CREATE TABLE wrong_question (
                                id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '错题ID',
                                user_id BIGINT NOT NULL COMMENT '用户ID',
                                question_id BIGINT NOT NULL COMMENT '题目ID',
                                bank_id BIGINT NOT NULL COMMENT '所属题库ID',
                                wrong_count INT DEFAULT 1 COMMENT '错误次数',
                                last_wrong_time DATETIME COMMENT '最后一次错误时间',
                                create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                                UNIQUE KEY uk_user_question (user_id, question_id),
                                INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='错题本表';

-- =============================================
-- 模块3：AI RAG智能问答模块
-- =============================================
DROP TABLE IF EXISTS ai_knowledge_base;
CREATE TABLE ai_knowledge_base (
                                   id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '知识库ID',
                                   doc_title VARCHAR(255) COMMENT '文档标题',
                                   content_chunk TEXT NOT NULL COMMENT '内容切片（RAG检索片段）',
                                   embedding MEDIUMTEXT COMMENT '向量嵌入（可选，用于向量检索）',
                                   create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                                   update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   deleted TINYINT DEFAULT 0,
                                   FULLTEXT KEY idx_content (content_chunk)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI知识库表';

-- =============================================
-- 模块4：信箱模块
-- =============================================
-- 4.1 私人私信表
DROP TABLE IF EXISTS private_message;
CREATE TABLE private_message (
                                 id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '私信ID',
                                 sender_id BIGINT NOT NULL COMMENT '发送者ID',
                                 receiver_id BIGINT NOT NULL COMMENT '接收者ID',
                                 content TEXT NOT NULL COMMENT '消息内容',
                                 is_read TINYINT DEFAULT 0 COMMENT '是否已读 0未读 1已读',
                                 send_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
                                 deleted TINYINT DEFAULT 0,
                                 INDEX idx_receiver_id (receiver_id),
                                 INDEX idx_sender_id (sender_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='私人私信表';

-- 4.2 公共意见反馈表（公共信箱）
DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '反馈ID',
                          user_id BIGINT NOT NULL COMMENT '提交反馈的用户ID',
                          content TEXT NOT NULL COMMENT '反馈内容',
                          status TINYINT DEFAULT 0 COMMENT '处理状态 0未处理 1已处理',
                          reply_content TEXT COMMENT '管理员回复内容',
                          reply_time DATETIME COMMENT '回复时间',
                          create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                          INDEX idx_user_id (user_id),
                          INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公共意见反馈表';

-- =============================================
-- 模块5：搜索模块
-- =============================================
DROP TABLE IF EXISTS search_hotword;
CREATE TABLE search_hotword (
                                id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                keyword VARCHAR(100) NOT NULL COMMENT '搜索关键词',
                                search_type TINYINT NOT NULL COMMENT '搜索类型 1社区帖子 2用户 3二手书商品',
                                search_count INT DEFAULT 1 COMMENT '搜索次数',
                                stat_date DATE NOT NULL COMMENT '统计日期',
                                UNIQUE KEY uk_keyword_type_date (keyword, search_type, stat_date),
                                INDEX idx_type_date (search_type, stat_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='搜索热词统计表';

-- =============================================
-- 模块6：二手书交易模块
-- =============================================
-- 6.1 二手书商品表
DROP TABLE IF EXISTS used_book;
CREATE TABLE used_book (
                           id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
                           seller_id BIGINT NOT NULL COMMENT '卖家用户ID',
                           book_name VARCHAR(100) NOT NULL COMMENT '书名',
                           category VARCHAR(50) COMMENT '书籍分类',
                           grade VARCHAR(20) COMMENT '适用年级（大一/大二/大三/大四）',
                           quantity INT NOT NULL DEFAULT 1 COMMENT '库存数量',
                           price DECIMAL(10,2) NOT NULL COMMENT '单价',
                           description TEXT COMMENT '商品描述',
                           images VARCHAR(1000) COMMENT '商品图片（JSON数组）',
                           status TINYINT DEFAULT 1 COMMENT '状态 1上架 0下架',
                           create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                           update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           deleted TINYINT DEFAULT 0,
                           INDEX idx_seller_id (seller_id),
                           INDEX idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='二手书商品表';

-- 6.2 购物车表
DROP TABLE IF EXISTS shopping_cart;
CREATE TABLE shopping_cart (
                               id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               user_id BIGINT NOT NULL COMMENT '买家ID',
                               book_id BIGINT NOT NULL COMMENT '商品ID',
                               quantity INT DEFAULT 1 COMMENT '商品数量',
                               create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                               UNIQUE KEY uk_user_book (user_id, book_id),
                               INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 6.3 订单表
DROP TABLE IF EXISTS book_order;
CREATE TABLE book_order (
                            id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '订单ID',
                            order_no VARCHAR(64) NOT NULL COMMENT '订单编号',
                            buyer_id BIGINT NOT NULL COMMENT '买家ID',
                            seller_id BIGINT NOT NULL COMMENT '卖家ID',
                            book_id BIGINT NOT NULL COMMENT '商品ID',
                            quantity INT NOT NULL COMMENT '购买数量',
                            total_price DECIMAL(10,2) NOT NULL COMMENT '订单总价',
                            order_status TINYINT NOT NULL DEFAULT 1 COMMENT '订单状态 1待接单 2待确认完成 3已完成 4已取消',
                            create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
                            confirm_time DATETIME COMMENT '完成确认时间',
                            UNIQUE KEY uk_order_no (order_no),
                            INDEX idx_buyer_id (buyer_id),
                            INDEX idx_seller_id (seller_id),
                            INDEX idx_status (order_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='二手书订单表';

-- =============================================
-- 模块7：社区模块
-- =============================================
-- 7.1 帖子表
DROP TABLE IF EXISTS post;
CREATE TABLE post (
                      id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '帖子ID',
                      user_id BIGINT NOT NULL COMMENT '发帖用户ID',
                      title VARCHAR(100) NOT NULL COMMENT '帖子标题',
                      content TEXT NOT NULL COMMENT '帖子正文',
                      images VARCHAR(1000) COMMENT '帖子图片（JSON数组）',
                      like_count INT DEFAULT 0 COMMENT '点赞数',
                      comment_count INT DEFAULT 0 COMMENT '评论数',
                      status TINYINT DEFAULT 1 COMMENT '状态 1正常 0下架',
                      create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                      update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                      deleted TINYINT DEFAULT 0,
                      INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='社区帖子表';

-- 7.2 帖子评论表
DROP TABLE IF EXISTS post_comment;
CREATE TABLE post_comment (
                              id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '评论ID',
                              post_id BIGINT NOT NULL COMMENT '所属帖子ID',
                              user_id BIGINT NOT NULL COMMENT '评论用户ID',
                              parent_id BIGINT DEFAULT 0 COMMENT '父评论ID（0为一级评论）',
                              content TEXT NOT NULL COMMENT '评论内容',
                              create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                              deleted TINYINT DEFAULT 0,
                              INDEX idx_post_id (post_id),
                              INDEX idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='帖子评论表';

-- 7.3 帖子点赞表
DROP TABLE IF EXISTS post_like;
CREATE TABLE post_like (
                           id BIGINT PRIMARY KEY AUTO_INCREMENT,
                           post_id BIGINT NOT NULL COMMENT '帖子ID',
                           user_id BIGINT NOT NULL COMMENT '点赞用户ID',
                           create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                           UNIQUE KEY uk_post_user (post_id, user_id),
                           INDEX idx_post_id (post_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='帖子点赞表';

-- =============================================
-- 初始化基础数据
-- =============================================
-- 初始化角色
INSERT INTO sys_role (role_name, role_code, description) VALUES
                                                             ('超级管理员', 'ROLE_SUPER_ADMIN', '拥有所有权限，可管理全部用户'),
                                                             ('管理员', 'ROLE_ADMIN', '可管理普通用户，处理反馈意见'),
                                                             ('普通用户', 'ROLE_USER', '默认注册角色，基础功能权限');

-- 初始化默认超级管理员（密码：admin123，BCrypt加密，实际使用请自行替换）
INSERT INTO sys_user (username, password, phone, status) VALUES
    ('admin', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '13800000000', 1);

-- 绑定超级管理员角色
INSERT INTO sys_user_role (user_id, role_id) VALUES (1, 1);
