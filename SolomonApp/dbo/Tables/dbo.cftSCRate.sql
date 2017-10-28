CREATE TABLE [dbo].[cftSCRate] (
    [AcctCat]       CHAR (16)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Period1]       CHAR (6)      NOT NULL,
    [Rate]          FLOAT (53)    NOT NULL,
    [SubType]       CHAR (16)     NOT NULL,
    [Type]          CHAR (16)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftSCRate0] PRIMARY KEY CLUSTERED ([AcctCat] ASC, [SubType] ASC, [Type] ASC) WITH (FILLFACTOR = 90)
);

