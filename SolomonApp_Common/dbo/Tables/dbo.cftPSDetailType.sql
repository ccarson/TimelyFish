CREATE TABLE [dbo].[cftPSDetailType] (
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [Descr]         CHAR (30)     NULL,
    [DetailTypeId]  CHAR (2)      NOT NULL,
    [GLAcct]        CHAR (10)     NULL,
    [InclFlg]       SMALLINT      NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [TranTypeID]    CHAR (2)      NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSDetailType0] PRIMARY KEY CLUSTERED ([DetailTypeId] ASC) WITH (FILLFACTOR = 90)
);

