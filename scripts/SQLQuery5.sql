CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	BEGIN TRY
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\CRM\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		-- select COUNT(*) from bronze.crm_cust_info

		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\CRM\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		-- SELECT * FROM bronze.crm_prd_info

		TRUNCATE TABLE bronze.crm_sales_details

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\CRM\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		-- SELECT * FROM bronze.crm_sales_details

		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\ERP\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		-- SELECT * FROM bronze.erp_cust_az12

		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\ERP\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		-- SELECT * FROM bronze.erp_loc_a101

		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\lucas\OneDrive\Documents\ProjetoDW\ArquivosCarregamento\ERP\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		-- SELECT * FROM bronze.erp_px_cat_g1v2
	END TRY
	BEGIN CATCH 
		PRINT'Error ocurred during loading bromze layer'
		PRINT'Error message' + ERROR_MESSAGE();
		PRINT'Error message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	END CATCH
END 

EXEC bronze.load_bronze 