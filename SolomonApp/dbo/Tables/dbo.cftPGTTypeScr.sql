CREATE TABLE [dbo].[cftPGTTypeScr] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [ScreenNbr]     CHAR (7)      NOT NULL,
    [TranTypeID]    CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPGTTypeScr0] PRIMARY KEY CLUSTERED ([TranTypeID] ASC, [ScreenNbr] ASC) WITH (FILLFACTOR = 90)
);

