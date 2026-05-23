-- 瑞名阁智能起名系统 - 数据库初始化脚本
-- MySQL >= 5.7, utf8mb4

CREATE DATABASE IF NOT EXISTS `name_imoons_cn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `name_imoons_cn`;

-- ==================== 起名记录表 ====================
CREATE TABLE IF NOT EXISTS `name_records` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `surname`     VARCHAR(10)  NOT NULL COMMENT '姓氏',
  `gender`      VARCHAR(10)  DEFAULT 'boy' COMMENT '性别',
  `birthday`    VARCHAR(20)  DEFAULT '' COMMENT '公历生日',
  `name`        TEXT         NOT NULL COMMENT '完整记录JSON，包含bazi/names等',
  `source`      VARCHAR(20)  DEFAULT 'local' COMMENT '来源：ai/local',
  `created_at`  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  INDEX         `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='起名记录';

-- ==================== 兑换码表 ====================
CREATE TABLE IF NOT EXISTS `redeem_codes` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `code`       VARCHAR(50)  NOT NULL COMMENT '兑换码',
  `amount`     INT           DEFAULT 0 COMMENT '兑换次数',
  `max_use`    INT           DEFAULT 0 COMMENT '最大使用次数，0=无限',
  `used_count` INT           DEFAULT 0 COMMENT '已使用次数',
  `status`     TINYINT       DEFAULT 1 COMMENT '状态：1启用 0禁用',
  `expired_at` DATETIME     DEFAULT NULL COMMENT '过期时间，NULL=永不过期',
  `created_at` TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  UNIQUE INDEX `idx_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='兑换码';

-- 初始兑换码数据
INSERT INTO `redeem_codes` (`code`, `amount`, `max_use`, `status`) VALUES
  ('U3A3ZY9',  10, 1, 1),
  ('JHH8BAMF', 50, 1, 1),
  ('MYCODE123',50, 5, 1),
  ('YHRVH9Q4', 10, 1, 1);

-- ==================== AI 配置表 ====================
CREATE TABLE IF NOT EXISTS `ai_configs` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `config_key` VARCHAR(100) NOT NULL,
  `config_val` TEXT,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE INDEX `idx_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI配置';

INSERT INTO `ai_configs` (`config_key`, `config_val`) VALUES
  ('ai_api_url',  'https://api.deepseek.com/v1/chat/completions'),
  ('ai_api_key',  ''),
  ('ai_model',    'deepseek-chat');

-- ==================== 用户表（预留） ====================
CREATE TABLE IF NOT EXISTS `users` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `username`   VARCHAR(50)   DEFAULT NULL,
  `phone`      VARCHAR(20)   DEFAULT NULL,
  `balance`    INT           DEFAULT 0 COMMENT '积分余额',
  `status`     TINYINT       DEFAULT 1,
  `created_at` TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ==================== 知识文章表 ====================
CREATE TABLE IF NOT EXISTS `knowledge_articles` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `title`       VARCHAR(200) NOT NULL,
  `summary`     TEXT,
  `content`     TEXT,
  `cover_image` VARCHAR(500) DEFAULT '' COMMENT '封面图URL',
  `views`       INT          DEFAULT 0,
  `likes`       INT          DEFAULT 0,
  `is_featured` TINYINT      DEFAULT 0 COMMENT '是否推荐',
  `created_at`  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX         `idx_featured` (`is_featured`),
  INDEX         `idx_created`  (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='知识文章';

