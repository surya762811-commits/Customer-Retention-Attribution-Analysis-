CREATE TABLE transactions (
transaction_id INT,
customer_id INT,
order_date DATETIME,
product_category VARCHAR(100),
quantity INT,
sales DECIMAL(10,2),
country VARCHAR(100)
);


CREATE TABLE marketing_touchpoints (
touch_id INT,
customer_id INT,
channel VARCHAR(50),
campaign VARCHAR(100),
touch_date DATETIME
);
