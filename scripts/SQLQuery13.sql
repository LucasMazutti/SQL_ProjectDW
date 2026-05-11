-- Tratando tabela a101



-- insert dentro da tabela silver

PRINT'>>Truncate table<<'
TRUNCATE TABLE silver.erp_loc_a101;
PRINT'>>Inserting Table<<'
INSERT INTO silver.erp_loc_a101(
	cid,
	centry
)
SELECT 
REPLACE(cid, '-', '') AS cid,
CASE WHEN centry = '' THEN	'n/a'
	WHEN centry IS NULL THEN 'n/a'
	 WHEN centry = 'DE' THEN 'Germany'
	 WHEN centry = 'US' THEN 'United States'
	 WHEN centry = 'USA' THEN 'United States'
	 ELSE centry
END AS centry
FROM bronze.erp_loc_a101;

-- Verficando join com a tabela crm_cust_info
SELECT cst_key FROM silver.crm_cust_info

-- transformando valores da coluna 'centry'
SELECT DISTINCT
CASE WHEN centry = '' THEN	'n/a'
	WHEN centry IS NULL THEN 'n/a'
	 WHEN centry = 'DE' THEN 'Germany'
	 WHEN centry = 'US' THEN 'United States'
	 WHEN centry = 'USA' THEN 'United States'
	 ELSE centry
END AS centry
FROM bronze.erp_loc_a101
ORDER BY centry

-- checando 

select *
from silver.erp_loc_a101