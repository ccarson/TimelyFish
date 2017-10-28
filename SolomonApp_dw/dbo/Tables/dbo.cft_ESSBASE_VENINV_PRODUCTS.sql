CREATE TABLE [dbo].[cft_ESSBASE_VENINV_PRODUCTS] (
    [InvtId]     CHAR (30) NOT NULL,
    [InvtIdDesc] CHAR (60) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_ESSBASE_VENINV_PRODUCTS] TO [SE\ssis_datareader]
    AS [dbo];

