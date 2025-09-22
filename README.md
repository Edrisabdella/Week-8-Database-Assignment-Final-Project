# Week-8-Database-Assignment-Final-Project
E-COMMERCE STORE DATABASE MANAGEMENT SYSTEM

---
# E-Commerce Database Management System

[E-Commerce DB](ERD_diagram.png)

**Author:** Edris Abdella  
**Created:** 21-09-2025  
**Technology:** MySQL 

---

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Database Schema](#database-schema)  
3. [Entity-Relationship Diagram (ERD)](#entity-relationship-diagram-erd)  
4. [Tables and Structure](#tables-and-structure)  
5. [Query Results](#query-results)  
6. [Setup Instructions](#setup-instructions)  
7. [License](#license)  

---

## Project Overview
This project implements a full-featured relational database for an e-commerce store.  
It includes tables for users, products, categories, orders, order items, reviews, and payments, ensuring robust management of the store data.

Key Features:  
- User management  
- Product catalog with categories  
- Order tracking with order items  
- Payment records  
- Product reviews  

---

## Database Schema
The database `ecommerce_store` includes the following tables:  
- `users`  
- `categories`  
- `products`  
- `orders`  
- `order_items`  
- `payments`  
- `reviews`  

Relationships are mostly **one-to-many**:
- One user → Many orders  
- One order → Many order items  
- One product → Many reviews  

---

## Entity-Relationship Diagram (ERD)
![ERD Diagram](assets/erd_diagram.png)

This diagram illustrates the relationships and primary/foreign keys between all tables.



## Tables and Structure

### Users
```sql
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
---
(Other tables: categories, orders, order_items, payments, reviews—structure available in database.sql)

---
Query Results

Here are the results of some key queries from the ecommerce_store database: you can select

Products Query

SELECT * FROM products;

Orders Query

SELECT * FROM orders;

Reviews Query

SELECT * FROM reviews;

---
Setup Instructions

1. Clone the Repository
git clone https://github.com/Edrisabdella/Week-8-Database-Assignment-Final-Project.git


2. Open MySQL and create the database
CREATE DATABASE IF NOT EXISTS ecommerce_store;
USE ecommerce_store;


3. Run the SQL scripts
mysql -u <username> -p ecommerce_store < database.sql

4. Query the tables using MySQL Workbench, Terminal, or your preferred client.
---

License

This project is open-source and free to use for educational purposes.
---

For any questions, contact Edris Abdella.

Contact

📧 Email: edrisabdella178@gmail.com
🔗 LinkedIn: www.linkedin.com/in/edris-abdella-nuure-7aa521177
🖥️ GitHub Profile: https://github.com/Edrisabdella

🌍 Location: Dire Dawa, Ethiopia
