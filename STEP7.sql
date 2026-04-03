-- 1
SELECT * FROM users;

-- 2
SELECT * FROM users
WHERE YEAR(created_at) = 2024;

-- 3
SELECT * FROM users
WHERE age < 30 AND gender = 'female';

-- 4
SELECT product_name, price FROM products;

-- 5
SELECT o.id AS order_id, u.name AS user_name, o.order_date
FROM orders o
JOIN users u ON o.user_id = u.id;

-- 6
SELECT oi.order_id, p.product_name, oi.quantity,
       p.price AS unit_price,
       (p.price * oi.quantity) AS total_price
FROM order_items oi
JOIN products p ON oi.product_id = p.id;

-- 7
SELECT u.id, u.name, COUNT(o.id) AS order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- 8
SELECT u.id, u.name,
       SUM(p.price * oi.quantity) AS total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY u.id, u.name;

-- 9
SELECT u.name,
       SUM(p.price * oi.quantity) AS total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
GROUP BY u.id, u.name
ORDER BY total_amount DESC
LIMIT 1;

-- 10
SELECT p.product_name,
       SUM(p.price * oi.quantity) AS sales_amount
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_name
ORDER BY sales_amount DESC;

-- 11
SELECT * FROM users
WHERE age >= 20;

-- 12
SELECT order_id
FROM order_items
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) >= 2;

-- 13
SELECT DISTINCT u.name
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE (p.price * oi.quantity) >= 10000;

-- 14
SELECT o.order_date, u.name, p.product_name,
       oi.quantity, (p.price * oi.quantity) AS total_price
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;

-- 15
SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- 16
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       COUNT(*) AS order_count
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- 17
SELECT p.*
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
WHERE oi.product_id IS NULL;

-- 18
CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

-- 19
SELECT u.id, u.name,
       AVG(order_total.total_amount) AS avg_order_amount
FROM users u
JOIN (
    SELECT o.id, o.user_id,
           SUM(p.price * oi.quantity) AS total_amount
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
    GROUP BY o.id, o.user_id
) order_total ON u.id = order_total.user_id
GROUP BY u.id, u.name;

-- 20
SELECT u.id, u.name,
       MAX(o.order_date) AS latest_order_date
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- 21
INSERT INTO users VALUES (6, '中村花', 25, 'female', '2025-06-01');

-- 22
INSERT INTO products VALUES (6, 'エアコン', 60000);

-- 23
INSERT INTO orders VALUES (10, 1, '2025-06-10');

-- 24
INSERT INTO order_items VALUES (10, 10, 6, 1);

-- 25
UPDATE users
SET age = 24
WHERE name = '田中美咲';

-- 26
UPDATE products
SET price = price * 1.10;

-- 27
UPDATE orders
SET order_date = '2024-05-01'
WHERE order_date <= '2024-05-31';

-- 28
DELETE FROM users
WHERE name = '高橋健一';

-- 29
DELETE FROM order_items
WHERE order_id = 5;

-- 30
DELETE FROM products
WHERE id NOT IN (SELECT DISTINCT product_id FROM order_items);
