CREATE TABLE [dbo].[cftPGStatHist] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [PGStatusID]    CHAR (2)      NOT NULL,
    [StatusDate]    SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPGStatHist0] PRIMARY KEY CLUSTERED ([PigGroupID] ASC, [PGStatusID] ASC, [StatusDate] ASC, [Crtd_DateTime] ASC) WITH (FILLFACTOR = 100)
);

