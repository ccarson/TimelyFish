CREATE TABLE [dbo].[cft_ESSBASE_VENINV_VENDORS] (
    [VendID]   CHAR (15) NOT NULL,
    [VendName] CHAR (60) NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_ESSBASE_VENINV_VENDORS] TO [SE\ssis_datareader]
    AS [dbo];

