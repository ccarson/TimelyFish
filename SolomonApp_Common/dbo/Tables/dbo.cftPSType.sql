CREATE TABLE [dbo].[cftPSType] (
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [Descr]         CHAR (30)     NULL,
    [GLAcct]        CHAR (10)     NULL,
    [GrpReqFlg]     SMALLINT      NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [SalesTypeId]   CHAR (2)      NOT NULL,
    [SubTypeID]     CHAR (2)      NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSType0] PRIMARY KEY CLUSTERED ([SalesTypeId] ASC) WITH (FILLFACTOR = 90)
);

