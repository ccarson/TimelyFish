CREATE TABLE [dbo].[cftPSOrdr] (
    [PSOrdrNbr]    CHAR (10)     NULL,
    [PSOrdrType]   CHAR (2)      NULL,
    [Descr]        CHAR (30)     NULL,
    [FirstDelDate] SMALLDATETIME NULL,
    [LastDelDate]  SMALLDATETIME NULL,
    [PkrContactID] CHAR (6)      NULL,
    [CustID]       CHAR (10)     NULL,
    [SaleBasis]    CHAR (2)      NULL,
    [BasePrice]    FLOAT (53)    NULL,
    [LoadQty]      SMALLINT      NULL,
    [TrkgPaidFlg]  SMALLINT      NULL
);

