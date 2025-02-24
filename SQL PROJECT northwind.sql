---1. Write a query to get Product name and quantity/unit.
SELECT product_name, quantity
FROM products p
JOIN order_details od ON p.product_id = od.product_id
;

---2. Write a query to get current Product list (Product ID and name).
SELECT product_id, product_name AS current_products
FROM products 
WHERE discontinued = 0
;

---3. Write a query to get the Products by Category
SELECT product_name, category_name AS categories
FROM products p
JOIN categories cat ON p.category_id = cat.category_id
;

---4. Write a query to get discontinued Product list (Product ID and name).
SELECT product_id, product_name AS discontinued_products
FROM products 
WHERE discontinued = 1
;

---5. Write a query to get most expense and least expensive Product list (name and unit price).
(SELECT product_name,  p.unit_price
FROM products p
ORDER BY p.unit_price DESC
LIMIT 1)
UNION
(SELECT product_name,  p.unit_price
FROM products p
ORDER BY p.unit_price
LIMIT 1);
				---OR---
SELECT ProducT_Name, Unit_Price
FROM Products
WHERE Unit_Price = (SELECT MAX(Unit_Price) FROM Products)
   OR Unit_Price = (SELECT MIN(Unit_Price) FROM Products)
;

---6. Write a query to get Product list (id, name, unit price) 
---where current products cost less than $20.
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price < 20 
AND discontinued = 0
;

---Write a query to get Product list (id, name, unit price) where products cost
---between $15 and $25.
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price BETWEEN 15 AND 25
;

---8. Write a query to get Product list (name, unit price) of above average price.
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
;

---9. Write a query to get Product list (name, unit price) of ten most expensive products.
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10
;

---10. Write a query to count current and discontinued products.
SELECT  product_name,
				CASE WHEN discontinued = 0 THEN 1 ELSE 0 END AS current_products,
				CASE WHEN discontinued = 1 THEN 1 ELSE 0 END AS discontinued_products
FROM products
;

---11. Write a query to get Product list (name, units on order , units in stock) 
---of stock is less than the quantity on order.
SELECT  product_name, units_on_order, units_in_stock
FROM products
WHERE units_in_stock < units_on_order
;

---12. For each employee, get their sales amount
SELECT CONCAT(first_name, ' ', last_name) employee, SUM(quantity * unit_price) AS sales_amount
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY employee
ORDER BY sales_amount DESC
;

---13. Write a query that returns the order and calculates sales price for each order 
--- after discount is applied.
SELECT o.order_id,  SUM(od.quantity * od.unit_price*(1-od.discount)) sales_price_after_discount
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id
ORDER BY sales_price_after_discount DESC
;

---14. For each category, get the list of products sold and the total sales amount per product
SELECT category_name, product_name, SUM(od.quantity * od.unit_price) as sales_amount
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_details od ON p.product_id = od.product_id
GROUP BY category_name, product_name
ORDER BY category_name, sales_amount DESC
;

---15. Write a query that shows sales figures by categories for the year 1997 alone
SELECT category_name, SUM(od.quantity * od.unit_price*(1-od.discount)) sales_amount
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE EXTRACT (YEAR FROM order_date) = 1997
GROUP BY category_name
;
