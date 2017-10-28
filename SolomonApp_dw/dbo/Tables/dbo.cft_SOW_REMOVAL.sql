CREATE TABLE [dbo].[cft_SOW_REMOVAL] (
    [PICYear_Week]  VARCHAR (6)  NULL,
    [FiscalPeriod]  SMALLINT     NOT NULL,
    [FiscalYear]    SMALLINT     NOT NULL,
    [ContactName]   CHAR (50)    NULL,
    [ContactID]     CHAR (6)     NOT NULL,
    [SiteID]        CHAR (4)     NOT NULL,
    [RemovalType]   VARCHAR (20) NULL,
    [PrimaryReason] VARCHAR (30) NULL,
    [GeneticLine]   VARCHAR (20) NULL,
    [Parity]        INT          NULL,
    [HeadCount]     INT          NULL
);

