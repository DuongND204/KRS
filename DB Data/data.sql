
-- Insert data first (before constraints)
INSERT INTO setting (title, created_at, type) VALUES
('Admin', NOW(), 'Role'),
('Teacher', NOW(), 'Role'),
('Student', NOW(), 'Role'),
('Subject Manager', NOW(), 'Role'),
('IT', NOW(), 'Category'),
('Business Administration', NOW(), 'Category'),
('Linguistics', NOW(), 'Category');

INSERT INTO `user` (`full_name`, `avatar`, `username`, `password_hash`, `email`, `role_id`, `status`, `created_at`)
VALUES ('Administrator', NULL, 'admin', MD5('admin'), 'admin@example.com', 1, 'Active', NOW());

use krsdb;
INSERT INTO subject (manager_id, created_by, category_id, domain_id, name, code, description, created_at) VALUES
(1, 1, 4, 5, 'Physics Fundamentals', 'PHYS01', 'Basic concepts of physics for high school students', NOW()),
(1, 1, 4, 5, 'Organic Chemistry', 'CHEM01', 'Introduction to organic chemistry principles', NOW()),
(1, 1, 4, 5, 'Computer Science Basics', 'CS01', 'Fundamentals of computer programming and algorithms', NOW()),
(1, 1, 4, 5, 'English Literature', 'ENG01', 'Study of classic and modern literature', NOW()),
(1, 1, 4, 5, 'World History', 'HIST01', 'Exploration of major historical events worldwide', NOW()),
(1, 1, 4, 5, 'Introduction to Economics', 'ECON01', 'Basic economic principles and market structures', NOW()),
(1, 1, 4, 5, 'Human Biology', 'BIO01', 'Study of the human body and biological systems', NOW()),
(1, 1, 4, 5, 'Psychology 101', 'PSY01', 'Introduction to psychology and human behavior', NOW()),
(1, 1, 4, 5, 'Graphic Design', 'GD01', 'Principles of visual communication and design software', NOW()),
(1, 1, 4, 5, 'Environmental Science', 'ENV01', 'Study of ecosystems, sustainability, and environmental issues', NOW());
