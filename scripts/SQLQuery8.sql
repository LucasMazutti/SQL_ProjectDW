SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
	WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Sigle'
	ELSE 'n/a' END,
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
	WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	ELSE 'n/a' END,
cst_create_date
FROM(
	SELECT
	*,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info) AS a
WHERE flag_last = 1


-- check espaços nos nomes
SELECT cst_firstname
FROM bronze.crm_cust_info 
WHERE cst_firstname != TRIM(cst_firstname)

-- check espaços nos nomes
SELECT cst_lastname
FROM bronze.crm_cust_info 
WHERE cst_lastname != TRIM(cst_lastname)

-- checando nulos e duplicatas

SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL
