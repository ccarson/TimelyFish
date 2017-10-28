CREATE TABLE [dbo].[cft_ESSBASE_VENINV_INV_DATA] (
    [Department] CHAR (10)  NOT NULL,
    [Location]   CHAR (16)  NOT NULL,
    [InvtId]     CHAR (30)  NOT NULL,
    [InvtIdDesc] CHAR (60)  NULL,
    [VendID]     CHAR (15)  NOT NULL,
    [VendName]   CHAR (60)  NOT NULL,
    [Acct]       CHAR (10)  NOT NULL,
    [AcctDescr]  CHAR (30)  NOT NULL,
    [Time]       CHAR (5)   NOT NULL,
    [Scenario]   CHAR (7)   NOT NULL,
    [Quantity]   FLOAT (53) NOT NULL,
    [Cost]       FLOAT (53) NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_ESSBASE_VENINV_INV_DATA] TO [SE\ssis_datareader]
    AS [dbo];

