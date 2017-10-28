CREATE TABLE [dbo].[xCPSetUp] (
    [BushConv]      FLOAT (53)    NOT NULL,
    [ChkOffRate]    FLOAT (53)    NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DefAcct]       CHAR (10)     NOT NULL,
    [DefPrem]       FLOAT (53)    NOT NULL,
    [DefSub]        CHAR (24)     NOT NULL,
    [LastCtrNbr]    CHAR (10)     NOT NULL,
    [LastAsyNbr]    CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PurgeSpan]     SMALLINT      NOT NULL,
    [SetUpId]       CHAR (2)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (10)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [xCPSetUp0] PRIMARY KEY CLUSTERED ([SetUpId] ASC) WITH (FILLFACTOR = 90)
);

