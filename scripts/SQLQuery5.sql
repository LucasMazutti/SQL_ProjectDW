CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_all DATETIME, @end_all DATETIME;
	BEGIN TRY
		SET @start_all = GETDATE();
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\CRM\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================'
		
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\CRM\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\CRM\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\ERP\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\ERP\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\ERP\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================'

		SET @end_all = GETDATE()
		PRINT 'All duration: ' + CAST(DATEDIFF(second, @start_all, @end_all) AS NVARCHAR) + ' second';

	END TRY
	BEGIN CATCH 
		PRINT'Error ocurred during loading bromze layer'
		PRINT'Error message' + ERROR_MESSAGE();
		PRINT'Error message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	END CATCH
END 

EXEC bronze.load_bronze 