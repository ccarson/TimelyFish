CREATE TABLE [dbo].[cftPigAcctTran] (
    [acct]          CHAR (16)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [TranTypeID]    CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPigAcctTran0] PRIMARY KEY CLUSTERED ([acct] ASC, [TranTypeID] ASC) WITH (FILLFACTOR = 90)
);

