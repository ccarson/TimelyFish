CREATE TABLE [dbo].[cftPSOrdDet] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (10)     NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [Qty]           SMALLINT      NOT NULL,
    [SaleDate]      SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSOrdDet0] PRIMARY KEY CLUSTERED ([OrdNbr] ASC, [SaleDate] ASC) WITH (FILLFACTOR = 100)
);

