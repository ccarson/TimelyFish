CREATE TABLE [dbo].[cftPSOrdHdr] (
    [BasePrice]     FLOAT (53)    NOT NULL,
    [ContrNbr]      CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CustID]        CHAR (15)     NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [FirstDelDate]  SMALLDATETIME NOT NULL,
    [LastDelDate]   SMALLDATETIME NOT NULL,
    [LoadQty]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [PkrContactID]  CHAR (6)      NOT NULL,
    [PSOrdType]     CHAR (2)      NOT NULL,
    [SaleBasis]     CHAR (2)      NOT NULL,
    [TrkgPaidFlg]   SMALLINT      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSOrdHdr0] PRIMARY KEY CLUSTERED ([OrdNbr] ASC) WITH (FILLFACTOR = 90)
);

