use my_database;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(18),
    email VARCHAR(28),
    city VARCHAR(38)
);
INSERT INTO customers (customer_id, customer_name, email, city)
VALUES
(1001, 'Sowmya', 'sowmya@gmail.com', 'Kerala'),
(1002, 'Keerthan', 'keerthan@gmail.com', 'Chennai'),
(1003, 'Varshini', 'varshini@gmail.com', 'Mangalore'),
(1004, 'Preya', 'preya@gmail.com', 'Mysore'),
(1005, 'Manvith', 'manvith@gmail.com', 'Kochi');

SELECT * FROM customers;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(30,2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO transactions
(transaction_id, customer_id, amount, transaction_date)
VALUES
(01, 1001, 2000, '2025-02-10'),
(02, 1002, 6800, '2025-03-12'),
(03, 1001, 5300, '2025-05-25'),
(04, 1003, 1900, '2025-04-11'),
(05, 1004, 8600, '2025-06-06'),
(06, 1002, 3200, '2025-09-12'),
(07, 1003, 9400, '2025-08-30'),
(08, 1004, 4300, '2025-11-15'),
(09, 1005, 3200, '2025-04-02'),
(10, 1005, 8500, '2025-05-14'),
(11, 1001, 1000, '2025-06-28'),
(12, 1002, 5500, '2025-07-09');

SELECT * FROM transactions;


CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(10,2),
    invoice_date DATE,
    due_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO invoices
(invoice_id, customer_id, invoice_amount, invoice_date, due_date, payment_status)
VALUES
(5001, 1001, 1500, '2025-01-10', '2026-11-30', 'Unpaid'),
(5002, 1002, 6500, '2025-02-28', '2026-11-15', 'Paid'),
(5003, 1003, 3900, '2025-03-13', '2026-11-20', 'Paid'),
(5004, 1004, 4400, '2025-04-02', '2026-11-25', 'Unpaid'),
(5005, 1005, 3700, '2025-05-30', '2026-11-28', 'Paid');

SELECT * FROM invoices;

select customer_name from customers where customer_id IN(
select customer_id from invoices where payment_status="unpaid");

select customer_name from customers where customer_id IN(
select customer_id from transactions where amount>4500);

select customer_name from customers where customer_id IN(
select customer_id from transactions where amount =(
select max(amount) from transactions));

select customer_name from transactions where amount>(
select avg(amount) from transactions);

select customer_name from customers 
where city='Mangalore' and customer_id IN(
select customer_id from transactions);