-- gold layer Product information

CREATE VIEW gold.dim_products AS 
SELECT
	ROW_NUMBER() OVER (ORDER BY a.prd_star_date, a.prd_key)  AS product_key,
	a.prd_id				AS product_id,
	a.prd_key				AS product_number,
	a.prd_nm				AS product_name,
	a.cat_id				AS category_id,
	b.cat					AS category,
	b.subcat				AS subcategory,
	b.maintenance,
	a.prd_cost				AS cost,
	a.prd_line				AS product_line,
	a.prd_star_date			AS start_date
	FROM silver.crm_prd_info AS a
LEFT JOIN silver.erp_px_cat_g1v2 AS B ON a.cat_id = b.id
	WHERE a.prd_end_date IS NULL -- Filtrando o histórico de data



-- CONTANDO DUPLICADAS
SELECT prd_key, COUNT(*) FROM(
SELECT
a.prd_id,
a.cat_id,
a.prd_key,
a.prd_nm,
a.prd_cost,
a.prd_line,
a.prd_star_date,
b.cat,
b.maintenance,
b.subcat
FROM silver.crm_prd_info AS a
LEFT JOIN silver.erp_px_cat_g1v2 AS B ON a.cat_id = b.id
WHERE a.prd_end_date IS NULL
) t GROUP BY prd_key 
HAVING COUNT (*) > 1