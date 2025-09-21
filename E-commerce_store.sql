-- =========================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- Author: Edris Abdella
-- Created: 21-09-2025
-- =========================================
-- Create Database
CREATE DATABASE IF NOT EXISTS ecommerce_store;
USE ecommerce_store;

-- Create Tables
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    category_id INT NOT NULL,
    image_url VARCHAR(255),
    weight DECIMAL(8, 2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    shipping_address TEXT NOT NULL,
    billing_address TEXT NOT NULL,
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer') DEFAULT 'credit_card',
    payment_status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    tracking_number VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE(user_id, product_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer') NOT NULL,
    transaction_id VARCHAR(100) UNIQUE,
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Insert Sample Data
INSERT INTO users (username, email, password_hash, first_name, last_name, phone, address, city, state, zip_code, country) VALUES
('edris_abdella', 'edrisabdella178@gmail.com', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'Edris', 'Abdella', '+251-905-131-051', 'Kezira', 'Dire Dawa', 'Dire Dawa', '3056', 'Ethiopia'),
('selam_tesfaye', 'selam.tesfaye@email.com', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'Selam', 'Tesfaye', '+251-911-234-567', 'Bole Road', 'Addis Ababa', 'Addis Ababa', '1000', 'Ethiopia'),
('yohannes_kebede', 'yohannes.kebede@email.com', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'Yohannes', 'Kebede', '+251-913-456-789', 'Central Market', 'Adama', 'Oromia', '2000', 'Ethiopia'),
('fatima_ahmed', 'fatima.ahmed@email.com', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'Fatima', 'Ahmed', '+251-914-567-890', 'Jegol District', 'Harar', 'Harari', '3000', 'Ethiopia');

INSERT INTO categories (name, description, parent_category_id) VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Computers', 'Computers and laptops', 1),
('Smartphones', 'Mobile phones and accessories', 1),
('Fashion', 'Clothing and accessories', NULL),
('Men''s Fashion', 'Clothing for men', 4),
('Women''s Fashion', 'Clothing for women', 4),
('Traditional Clothing', 'Ethiopian traditional clothing', 4),
('Food & Beverages', 'Ethiopian food and drinks', NULL),
('Coffee', 'Ethiopian coffee products', 8),
('Spices', 'Ethiopian spices', 8);

INSERT INTO products (name, description, price, stock_quantity, category_id, image_url, weight) VALUES
('Tecno Spark 10', 'Latest smartphone with excellent camera', 8500.00, 25, 3, '/images/tecno_spark10.jpg', 0.18),
('Infinix Hot 30', 'Affordable smartphone with long battery life', 7200.00, 30, 3, '/images/infinix_hot30.jpg', 0.17),
('HP Pavilion Laptop', 'Reliable laptop for work and study', 35000.00, 15, 2, '/images/hp_pavilion.jpg', 2.10),
('Dell Inspiron Laptop', 'Powerful laptop for professionals', 42000.00, 12, 2, '/images/dell_inspiron.jpg', 2.05),
('Men''s Casual Shirt', 'Comfortable cotton shirt for men', 1200.00, 50, 5, '/images/mens_shirt.jpg', 0.3),
('Women''s Habesha Kemis', 'Traditional Ethiopian dress', 2500.00, 40, 7, '/images/habesha_kemis.jpg', 0.5),
('Men''s Netela', 'Traditional Ethiopian shawl', 800.00, 60, 7, '/images/netela.jpg', 0.2),
('Yirgacheffe Coffee', 'Premium Ethiopian coffee beans', 450.00, 100, 9, '/images/yirgacheffe.jpg', 0.25),
('Harar Coffee', 'Authentic Harari coffee', 480.00, 80, 9, '/images/harar_coffee.jpg', 0.25),
('Berbere Spice', 'Traditional Ethiopian spice blend', 200.00, 120, 10, '/images/berbere.jpg', 0.1),
('Mitmita Spice', 'Spicy Ethiopian seasoning', 180.00, 110, 10, '/images/mitmita.jpg', 0.1);

INSERT INTO orders (user_id, total_amount, status, shipping_address, billing_address, payment_method, payment_status) VALUES
(1, 9700.00, 'delivered', 'Kezira, Dire Dawa, Ethiopia - 3056', 'Kezira, Dire Dawa, Ethiopia - 3056', 'bank_transfer', 'completed'),
(2, 42000.00, 'processing', 'Bole Road, Addis Ababa, Ethiopia - 1000', 'Bole Road, Addis Ababa, Ethiopia - 1000', 'credit_card', 'completed'),
(3, 3700.00, 'shipped', 'Central Market, Adama, Oromia, Ethiopia - 2000', 'Central Market, Adama, Oromia, Ethiopia - 2000', 'bank_transfer', 'completed'),
(4, 5300.00, 'pending', 'Jegol District, Harar, Harari, Ethiopia - 3000', 'Jegol District, Harar, Harari, Ethiopia - 3000', 'credit_card', 'pending');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 1, 1, 8500.00, 8500.00),
(1, 11, 6, 200.00, 1200.00),
(2, 4, 1, 42000.00, 42000.00),
(3, 6, 1, 2500.00, 2500.00),
(3, 10, 6, 200.00, 1200.00),
(4, 8, 10, 450.00, 4500.00),
(4, 9, 2, 400.00, 800.00);

INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Excellent phone with great camera quality!'),
(2, 4, 4, 'Powerful machine but a bit expensive'),
(3, 6, 5, 'Beautiful traditional dress, perfect for special occasions'),
(4, 8, 5, 'Best coffee I have ever tasted!');

INSERT INTO payments (order_id, amount, payment_method, transaction_id, status) VALUES
(1, 9700.00, 'bank_transfer', 'txn_ET123456789', 'completed'),
(2, 42000.00, 'credit_card', 'txn_ET987654321', 'completed'),
(3, 3700.00, 'bank_transfer', 'txn_ET456789123', 'completed');