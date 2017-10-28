CREATE TABLE [dbo].[smCommData] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [LaborPercent]    FLOAT (53)    NOT NULL,
    [LastDateEnd]     SMALLDATETIME NOT NULL,
    [LastDateStart]   SMALLDATETIME NOT NULL,
    [LastPeriodID]    CHAR (10)     NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [MaterialPercent] FLOAT (53)    NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           SMALLDATETIME NOT NULL,
    [User6]           SMALLDATETIME NOT NULL,
    [User7]           CHAR (10)     NOT NULL,
    [User8]           CHAR (10)     NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [smCommData0] PRIMARY KEY CLUSTERED ([LastPeriodID] ASC) WITH (FILLFACTOR = 90)
);

