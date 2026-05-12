CREATE OR ALTER PROCEDURE silver.load_silver AS
	BEGIN
		DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
		BEGIN TRY
			SET @batch_start_time = GETDATE();
			PRINT '===================================='
			PRINT 'Loading silver layer'
			PRINT '===================================='
			PRINT 'Loading CRM tables'

	SET @start_time = GETDATE();
	PRINT'>>Truncating Table<<'
	TRUNCATE TABLE silver.crm_prd_info;
	PRINT'>>Inserting Table<<'
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
	SET @end_time = GETDATE()
	PRINT ' Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'second'
	PRINT '========================================='

	SET @start_time = GETDATE();
	PRINT'>>Truncate table<<'
	TRUNCATE TABLE silver.crm_cust_info;
	PRINT'>>Inserting Table'
	INSERT INTO silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_material_status,
	cst_gndr,
	cst_create_date
	)
	SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	CASE WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
		WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Sigle'
		ELSE 'n/a' 
	END cst_marterial_status,
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'n/a' 
	END cst_gndr,
	cst_create_date
	FROM(
		SELECT
		*,
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
		FROM bronze.crm_cust_info) AS a
	WHERE flag_last = 1
	SET @end_time = GETDATE()
	PRINT ' Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'second'
	PRINT '========================================='

	SET @start_time = GETDATE();
	PRINT'>>Truncating Table<<'
	TRUNCATE TABLE silver.crm_sales_details;
	PRINT'>>Inserting table<<'
	INSERT INTO silver.crm_sales_details(
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	)
	SELECT 
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE WHEN sls_order_dt = 0 
		OR LEN(sls_order_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END AS sls_order_dt,
	CASE WHEN sls_ship_dt = 0 
		OR LEN(sls_ship_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE) 
	END AS sls_ship_dt,
	CASE WHEN sls_due_dt = 0 
		OR LEN(sls_due_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) 
	END AS sls_due_dt,
	CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
		END AS sls_sales,
	sls_quantity,
	CASE WHEN sls_price IS NULL OR sls_price <= 0
		 THEN sls_quantity / NULLIF(sls_sales, 0)
		 ELSE sls_price 
		 END  sls_price
	FROM bronze.crm_sales_details
	SET @end_time = GETDATE()
	PRINT ' Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'second'
	PRINT '========================================='

	SET @start_time = GETDATE();
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
	SET @end_time = GETDATE()
	PRINT ' Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'second'
	PRINT '========================================='

	SET @start_time = GETDATE();
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
	SET @end_time = GETDATE()
	PRINT ' Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'second'
	PRINT '========================================='

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table<<'
	TRUNCATE TABLE silver.erp_px_cat_g1v2;
	PRINT '>> Inserting Table<<'
	INSERT INTO silver.erp_px_cat_g1v2(
	id,
	cat,
	subcat,
	maintenance
	)
	SELECT 
	id,
	cat,
	subcat,
	maintenance
	FROM bronze.erp_px_cat_g1v2;
	SET @end_time = GETDATE()
	PRINT ' Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'second'
	PRINT '========================================='

	SET @batch_end_time = GETDATE()
	PRINT 'Second: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'second'

	END TRY
	BEGIN CATCH 
		PRINT '==============================='
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==============================='
	END CATCH
END

	
