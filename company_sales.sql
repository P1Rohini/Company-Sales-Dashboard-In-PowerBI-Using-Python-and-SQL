CREATE DATABASE company_dw;
USE company_dw;

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    week INT,
    day INT,
    day_name VARCHAR(20),
    is_weekend BOOLEAN
);

INSERT INTO dim_date
SELECT 
    DATE_FORMAT(d, '%Y%m%d') AS date_id,
    d AS full_date,
    YEAR(d),
    QUARTER(d),
    MONTH(d),
    MONTHNAME(d),
    WEEK(d),
    DAY(d),
    DAYNAME(d),
    CASE WHEN DAYOFWEEK(d) IN (1,7) THEN TRUE ELSE FALSE END
FROM (
    SELECT DATE('2022-01-01') + INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY AS d
    FROM (SELECT 0 a UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN 
         (SELECT 0 a UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN 
         (SELECT 0 a UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
) dates
WHERE d BETWEEN '2022-01-01' AND '2024-12-31';

CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    segment VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

INSERT INTO dim_customer 
(customer_name, gender, age, segment, city, state, country, signup_date)

SELECT 
    CONCAT('Customer_', n),
    ELT(FLOOR(1 + RAND()*2), 'Male','Female'),
    FLOOR(18 + RAND()*50),
    ELT(FLOOR(1 + RAND()*3), 'Consumer','Corporate','Small Business'),
    ELT(FLOOR(1 + RAND()*5), 'New York','Chicago','Los Angeles','Houston','Miami'),
    'State',
    'USA',
    DATE('2022-01-01') + INTERVAL FLOOR(RAND()*1000) DAY

FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
    CROSS JOIN 
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
    CROSS JOIN 
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) c
) numbers
WHERE n <= 500;

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    cost DECIMAL(10,2),
    price DECIMAL(10,2)
);

INSERT INTO dim_product 
(product_name, category, subcategory, cost, price)

SELECT 
    CONCAT('Product_', n),
    ELT(FLOOR(1 + RAND()*3), 'Electronics','Furniture','Office Supplies'),
    ELT(FLOOR(1 + RAND()*4), 'Phones','Chairs','Binders','Storage'),
    ROUND(RAND()*200,2),
    ROUND(200 + RAND()*800,2)

FROM (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
    CROSS JOIN 
        (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
) numbers
WHERE n <= 100;

CREATE TABLE dim_employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    region VARCHAR(50),
    hire_date DATE
);

CREATE TABLE dim_channel (
    channel_id INT PRIMARY KEY AUTO_INCREMENT,
    channel_name VARCHAR(50)
);

INSERT INTO dim_channel (channel_name)
VALUES ('Online'), ('Retail Store'), ('Distributor');

CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY AUTO_INCREMENT,
    date_id INT,
    customer_id INT,
    product_id INT,
    employee_id INT,
    channel_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    sales_amount DECIMAL(12,2),
    cost_amount DECIMAL(12,2),
    profit DECIMAL(12,2),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (employee_id) REFERENCES dim_employee(employee_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id)
);

INSERT INTO fact_sales (
    date_id, customer_id, product_id, employee_id, channel_id,
    quantity, discount, sales_amount, cost_amount, profit
)
SELECT
    d.date_id,
    c.customer_id,
    p.product_id,
    e.employee_id,
    ch.channel_id,
    FLOOR(1 + RAND()*10),
    ROUND(RAND()*0.3,2),
    ROUND(100 + RAND()*2000,2),
    ROUND(50 + RAND()*1000,2),
    ROUND((100 + RAND()*2000) - (50 + RAND()*1000),2)

FROM 
    (SELECT date_id FROM dim_date ORDER BY RAND() LIMIT 10000) d
JOIN dim_customer c ON TRUE
JOIN dim_product p ON TRUE
JOIN dim_employee e ON TRUE
JOIN dim_channel ch ON TRUE
LIMIT 10000;