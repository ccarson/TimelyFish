CREATE TABLE [dbo].[cft_ESSBASE_VENINV_WAREHOUSES] (
    [WarehouseRollup] CHAR (24) NULL,
    [Warehouse]       CHAR (16) NOT NULL,
    [WH_Name]         CHAR (32) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_ESSBASE_VENINV_WAREHOUSES] TO [SE\ssis_datareader]
    AS [dbo];

