-- Gold layer 

CREATE VIEW gold.dim_customers AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
a.cst_id							AS costumer_id,
a.cst_key							AS customer_number,
a.cst_firstname						AS first_name,
a.cst_lastname						AS last_name,
a.cst_material_status				AS marital_status,
CASE WHEN a.cst_gndr != 'n/a' THEN a.cst_gndr
	ELSE COALESCE(b.gen, 'n/a')
END									AS gender,
c.centry							AS country,
b.bdate								AS birth_date,
a.cst_create_date					AS create_dat
FROM silver.crm_cust_info a
LEFT JOIN silver.erp_cust_az12 b ON a.cst_key = b.cid
LEFT JOIN silver.erp_loc_a101 c ON a.cst_key = c.cid


-- Estudo de caso para tratamentos de nulos e dados incosistentes entre as tabelas
SELECT DISTINCT 
a.cst_gndr,
b.gen,
CASE WHEN a.cst_gndr != 'n/a' THEN a.cst_gndr
	ELSE COALESCE(b.gen, 'n/a')
END AS new_gen -- iremos levar em consideração a tabela CRM para tratar
FROM silver.crm_cust_info a
LEFT JOIN silver.erp_cust_az12 b ON a.cst_key = b.cid
LEFT JOIN silver.erp_loc_a101 c ON a.cst_key = c.cid
ORDER BY 1, 2

-- Testando a nova view de acordo com a arquitetura ouro
SELECT * FROM gold.dim_customers

