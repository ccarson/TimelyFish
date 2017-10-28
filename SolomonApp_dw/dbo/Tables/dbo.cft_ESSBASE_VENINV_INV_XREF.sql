CREATE TABLE [dbo].[cft_ESSBASE_VENINV_INV_XREF] (
    [Module]     CHAR (10)  NOT NULL,
    [BatNbr]     CHAR (10)  NOT NULL,
    [RefNbr]     CHAR (15)  NOT NULL,
    [Acct]       CHAR (10)  NOT NULL,
    [InvtId]     CHAR (30)  NULL,
    [InvtIdDesc] CHAR (60)  NULL,
    [PerPost]    CHAR (6)   NOT NULL,
    [sub]        CHAR (24)  NOT NULL,
    [ProjectID]  CHAR (16)  NULL,
    [SiteID]     CHAR (10)  NULL,
    [SiteName]   CHAR (60)  NULL,
    [VendID]     CHAR (15)  NULL,
    [VendName]   CHAR (60)  NULL,
    [qty]        FLOAT (53) NOT NULL,
    [cost]       FLOAT (53) NOT NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_ESSBASE_VENINV_INV_XREF] TO [SE\ssis_datareader]
    AS [dbo];

