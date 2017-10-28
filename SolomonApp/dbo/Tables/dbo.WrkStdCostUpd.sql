CREATE TABLE [dbo].[WrkStdCostUpd] (
    [Acct]     CHAR (10)  NULL,
    [Computer] CHAR (21)  NULL,
    [Descr]    CHAR (60)  NULL,
    [InvtId]   CHAR (30)  NULL,
    [PendCost] FLOAT (53) NULL,
    [SiteId]   CHAR (10)  NULL,
    [SiteName] CHAR (30)  NULL,
    [StdCost]  FLOAT (53) NULL,
    [Sub]      CHAR (24)  NULL,
    [tstamp]   ROWVERSION NULL
);

