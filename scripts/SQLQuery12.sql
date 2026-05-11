-- Tratando tabela az12

PRINT'>>Truncating table<<'
TRUNCATE TABLE silver.erp_cust_az12;
PRINT'>>Inserting table<<'
INSERT INTO silver.erp_cust_az12(
	cid,
	bdate,
	gen
)
SELECT 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) 
	ELSE cid
	END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
	ELSE bdate
	END AS bdate,
CASE WHEN UPPER(TRIM(gen)) = 'M' THEN 'Male' 
	WHEN UPPER(TRIM(gen)) = 'F' THEN 'Female'
	WHEN UPPER(TRIM(gen)) = '' THEN 'n/a'
	WHEN gen IS NULL THEN 'n/a'
	ELSE gen
END AS gen
FROM bronze.erp_cust_az12

-- validações

select *
from bronze.erp_cust_az12
WHERE bdate > getdate()

SELECT DISTINCT 
gen
FROM bronze.erp_cust_az12



