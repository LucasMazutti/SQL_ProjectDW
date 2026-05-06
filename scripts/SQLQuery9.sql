-- transformando tabela prd_info

INSERT INTO silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_star_date,
	prd_end_date
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1,5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
	 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
	 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Outras'
	 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
CAST(prd_star_date AS DATE) AS prd_star_date,
CAST(LEAD(prd_star_date) OVER (PARTITION BY prd_key ORDER BY prd_star_date) -1 AS DATE) AS prd_end_date
FROM bronze.crm_prd_info

-- transformando tabela de vendas
SELECT 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key, 1,5), '-', '_') AS cat_id, -- coluna para join
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- coluna para join
prd_nm,
prd_cost,
prd_line,
prd_star_date,
prd_end_date
FROM bronze.crm_prd_info
WHERE SUBSTRING(prd_key, 7, LEN(prd_key)) IN 
 (SELECT sls_prd_key FROM bronze.crm_sales_details)


-- Querys de consulta das tabelas tratadas.--
-- valores numéricos abaixo de zero ou null
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

SELECT DISTINCT prd_line 
FROM silver.crm_prd_info

SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT *
FROM silver.crm_prd_info
