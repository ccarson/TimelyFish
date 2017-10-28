CREATE TABLE [dbo].[cftPigGradeAcct] (
    [Acct]              CHAR (16)     NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME NULL,
    [Crtd_Prog]         CHAR (8)      NULL,
    [Crtd_User]         CHAR (10)     NULL,
    [Lupd_DateTime]     SMALLDATETIME NULL,
    [Lupd_Prog]         CHAR (8)      NULL,
    [Lupd_User]         CHAR (10)     NULL,
    [PigGradeCatTypeID] CHAR (2)      NOT NULL,
    [tstamp]            ROWVERSION    NULL,
    CONSTRAINT [cftPigGradeAcct0] PRIMARY KEY CLUSTERED ([PigGradeCatTypeID] ASC, [Acct] ASC) WITH (FILLFACTOR = 90)
);

