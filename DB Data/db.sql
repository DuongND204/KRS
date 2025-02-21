	DROP DATABASE IF EXISTS `KRSDB`;
CREATE DATABASE `KRSDB`;

USE `KRSDB`;

CREATE TABLE `user` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `full_name` varchar(255),
  `avatar` varchar(255),
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(32) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role_id` integer NOT NULL,
  `status` enum('Active', 'Deactivated', 'NotVerified'),
  `created_at` timestamp,
  `modified_at` timestamp,
  `modified_by` integer
);

CREATE TABLE `setting` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `created_by` integer,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp,
  `type` enum('Role', 'Category'),
  `modified_at` timestamp,
  `modified_by` integer
);

CREATE TABLE `subject` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `manager_id` integer,
  `created_by` integer NOT NULL,
  `category_id` integer,
  `domain_id` integer,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` text,
  `created_at` timestamp,
  `modified_at` timestamp,
  `modified_by` integer,
  `status` ENUM('Active', 'Inactive') DEFAULT 'Active'
);

CREATE TABLE `lesson` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `subject_id` integer NOT NULL,
  `created_by` integer NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `created_at` timestamp,
  `modified_at` timestamp,
  `modified_by` integer
);

CREATE TABLE `config` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `type` enum('Domain', 'Skill', 'Module', 'Lesson Chapter')
);

CREATE TABLE `lesson_config` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `lesson_id` integer,
  `config_id` integer
);

CREATE TABLE `class` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `subject_id` integer,
  `manager_id` integer,
  `class_name` varchar(255),
  `code` varchar(255),
  `created_at` timestamp,
  `created_by` integer,
  `modified_at` timestamp,
  `modified_by` integer
);

CREATE TABLE `class_user` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `class_id` integer,
  `user_id` integer,
  `modified_at` timestamp,
  `modified_by` integer
);

CREATE TABLE `subject_manager`(
	`id` integer PRIMARY KEY AUTO_INCREMENT,
  `subject_id` integer,
  `manager_id` integer,
  `time` TIMESTAMP,
  `action` Enum('active', 'inactive', 'modified')
);
-- Then add all constraints
ALTER TABLE `class_user` ADD FOREIGN KEY (`class_id`) REFERENCES `class` (`id`);
ALTER TABLE `class_user` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

ALTER TABLE `setting` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);
ALTER TABLE `user` ADD FOREIGN KEY (`role_id`) REFERENCES `setting` (`id`);

ALTER TABLE `subject` ADD FOREIGN KEY (`category_id`) REFERENCES `setting` (`id`);
ALTER TABLE `subject` ADD FOREIGN KEY (`domain_id`) REFERENCES `setting` (`id`);

ALTER TABLE `lesson` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`);

ALTER TABLE `subject` ADD FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`);
ALTER TABLE `subject` ADD FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);
ALTER TABLE `subject` ADD FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`);

ALTER TABLE `class_user` ADD FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`);
ALTER TABLE `class` ADD FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`);

ALTER TABLE `class` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`);
ALTER TABLE `class` ADD FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`);

ALTER TABLE `lesson_config` ADD FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`);
ALTER TABLE `lesson_config` ADD FOREIGN KEY (`config_id`) REFERENCES `config` (`id`);

ALTER TABLE `subject_manager` ADD FOREIGN KEY (`manager_id`) REFERENCES `user` (`id`);
ALTER TABLE `subject_manager` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`id`);