-- table of sales


CREATE VIEW gold.fact_sales AS
SELECT 
a.sls_ord_num			AS order_number,
b.product_key,
c.customer_key,
a.sls_order_dt			AS order_date,
a.sls_ship_dt			AS shipping_date,
a.sls_due_dt			AS due_date,
a.sls_sales				AS sales_amount,
a.sls_quantity			AS quantity,
a.sls_price				AS price
FROM silver.crm_sales_details AS a
LEFT JOIN gold.dim_products AS b ON a.sls_prd_key = b.product_number
LEFT JOIN gold.dim_customers AS c ON a.sls_cust_id = c.costumer_id

-- checando quality

select * from gold.fact_sales