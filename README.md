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
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Products

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
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