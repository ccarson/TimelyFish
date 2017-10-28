CREATE TABLE [dbo].[cftPigAcctScrn] (
    [acct]          CHAR (16)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [ScrnNbr]       CHAR (8)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPigAcctScrn0] PRIMARY KEY CLUSTERED ([acct] ASC, [ScrnNbr] ASC) WITH (FILLFACTOR = 90)
);

