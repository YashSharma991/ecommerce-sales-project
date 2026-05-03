             # create database:-
create database E_Commerce;

             # Show Databases:-
show databases;

            # Use database:-
use E_Commerce;

-- 1️. Create Table: categories:-
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    description VARCHAR(255)
);

INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Gadgets & Devices'),
(2, 'Clothing', 'Apparel & Wear'),
(3, 'Books', 'All kinds of books'),
(4, 'Home & Kitchen', 'Household items');

-- 2️. Create Table: products:-
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products (product_id, product_name, category_id, price, stock_quantity) VALUES
(1, 'Smartphone', 1, 30000, 50),
(2, 'Laptop', 1, 50000, 20),
(3, 'T-Shirt', 2, 500, 100),
(4, 'Jeans', 2, 1200, 80),
(5, 'Novel', 3, 200, 150),
(6, 'Cooking Pan', 4, 1500, 60),
(7, 'Blender', 4, 2500, 40);

-- 3️. Create Table: customers:-
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255)
);

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address) VALUES
(1, 'Raj', 'Sharma', 'raj@gmail.com', '9876543210', 'Delhi'),
(2, 'Priya', 'Singh', 'priya@gmail.com', '9123456780', 'Mumbai'),
(3, 'Amit', 'Verma', 'amit@gmail.com', '9988776655', 'Bangalore'),
(4, 'Sneha', 'Kapoor', 'sneha@gmail.com', '9112233445', 'Pune');

-- 4️.Create Table: orders:-
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(1, 1, '2026-03-01', 'Completed'),
(2, 2, '2026-03-02', 'Pending'),
(3, 3, '2026-03-03', 'Completed'),
(4, 4, '2026-03-04', 'Shipped');

-- 5️.Create Table: order_items:-
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 30000),
(2, 1, 5, 2, 200),
(3, 2, 3, 3, 500),
(4, 3, 2, 1, 50000),
(5, 3, 6, 1, 1500),
(6, 4, 4, 2, 1200),
(7, 4, 7, 1, 2500);

-- 6️. Create Table: payments:-
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments (payment_id, order_id, payment_date, amount, payment_method) VALUES
(1, 1, '2026-03-01', 30400, 'Credit Card'),
(2, 2, '2026-03-02', 1500, 'Cash'),
(3, 3, '2026-03-03', 51500, 'Debit Card'),
(4, 4, '2026-03-04', 4900, 'UPI');

show tables;

#  Display all categories:-
select * from Categories;

# Show all products:-
select* from Products;

# Get product name and price:-
select product_name,price from Products;

 # List all customers:-
select * from Customers;

 # Show all orders:-
select * from Orders;

# Find products with price greater than 1000:-
select product_name, price from Products where price>1000;

# 7. Show customers from a specific city:-
select * from customers where address ='Delhi';

# 8. Display orders placed after 2024-01-01:-
select * from Orders where Order_date >'2024-01-01';

# 9. Show unique payment methods:-
select distinct payment_method from Payments;

# 10. Count total number of products:-
select count(*) as Total_numbers from Products;

                                   #    2.Intermediate SQL Queries (10):-

# 11. Show products with their category names:-
select p.product_name, c.category_name 
from Products p 
join categories c
 on p.category_id = c.category_id;
 
# 12. List customers and their orders:-
select c.first_name, o.order_id, order_date 
from customers c 
join orders o
on c.customer_id=o.customer_id;

# 13. Get total number of orders per customer:-
select customer_id, count(order_id) as Total_order
from orders group by customer_id;

# 14. Show total payment amount per order:-
SELECT order_id, SUM(amount) AS total_payment
FROM payments
GROUP BY order_id;

# 15. Find the most expensive product:-
SELECT *
FROM products
ORDER BY price DESC
LIMIT 1;

# 16. Show products that belong to category 1:-
select * from Products where category_id=1;

# 17. Find customers who placed more than 2 orders:-
SELECT 
    customer_id, COUNT(order_id) AS order_counts
FROM
    orders
GROUP BY customer_id
HAVING COUNT(order_id) > 2;

# 18. Show total quantity sold per product:-
SELECT 
    product_id, SUM(quantity) AS total_sold
FROM
    order_items
GROUP BY product_id;

# 19. Display orders with customer names:-
SELECT 
    c.first_name, o.order_id, o.order_date AS total_orders
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id;

# 20. Find the average price of all products:-
SELECT 
    AVG(price) AS average_price
FROM
    products; 

#  21. Calculate total revenue generated by each product:-
SELECT 
    p.product_name, SUM(oi.quantity * oi.price) AS Total_revenue
FROM
    order_items oi
        JOIN
    products p ON oi.product_id = p.product_id
GROUP BY product_name;

# 22. Find the top 3 customers based on total spending:-
SELECT 
    c.first_name, SUM(p.amount) AS Total_spent
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    payments p ON p.order_id = o.order_id
GROUP BY c.first_name
ORDER BY Total_spent DESC
LIMIT 3;

# 23. Find products that have never been ordered:-
SELECT 
    product_name
FROM
    products
WHERE
    product_id NOT IN (SELECT 
            product_id
        FROM
            order_items);

# 24. Find customers who have never placed an order:-
SELECT 
    first_name
FROM
    customers
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            orders);

# 25. Generate monthly revenue report:-
SELECT 
    MONTH(o.order_date) AS months,
    SUM(p.amount) AS total_revenue
FROM
    orders o
        JOIN
    payments p ON o.order_id = p.order_id
GROUP BY MONTH(o.order_date);

# 26. Calculate category-wise total sales:-
SELECT 
    c.category_name, SUM(oi.quantity * oi.price) AS Total_sale
FROM
    categories c
        JOIN
    products pr ON c.category_id = pr.category_id
        JOIN
    order_items oi ON oi.product_id = pr.product_id
GROUP BY category_name;

# 27. Find the most ordered product:-
SELECT 
    p.product_name, SUM(oi.quantity) AS most_orderd_product
FROM
    products p
        JOIN
    order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY most_orderd_product DESC
LIMIT 1; 

# 28. Calculate average order value per customer:-
SELECT 
    c.first_name, AVG(p.amount) AS total_average
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    payments p ON o.order_id = p.order_id
GROUP BY c.first_name;

# 29. Rank products based on total sales:-
select p.product_name,
sum(oi.quantity*oi.price) as total_sales,
rank() over(order by sum(oi.quantity*oi.price) desc) as ranked
from order_items oi 
join products p on p.product_id = oi.product_id
group by product_name;

# 30. Find customers who spent more than the average spending:-
SELECT 
    first_name, total_spent
FROM
    (SELECT 
        c.first_name, SUM(p.amount) AS total_spent
    FROM
        customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.first_name) AS customers_spending
WHERE
    total_spent > (SELECT 
            AVG(amount)
        FROM
            payments);




































