CREATE TABLE [dbo].[Account] (
    [Acct]          CHAR (10)     NOT NULL,
    [AcctType]      CHAR (2)      NOT NULL,
    [Acct_Cat]      CHAR (16)     NOT NULL,
    [Acct_Cat_SW]   CHAR (1)      NOT NULL,
    [Active]        SMALLINT      NOT NULL,
    [ClassID]       CHAR (10)     NOT NULL,
    [ConsolAcct]    CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CuryId]        CHAR (4)      NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [Employ_Sw]     CHAR (1)      NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [RatioGrp]      CHAR (2)      NOT NULL,
    [S4Future01]    CHAR (30)     NOT NULL,
    [S4Future02]    CHAR (30)     NOT NULL,
    [S4Future03]    FLOAT (53)    NOT NULL,
    [S4Future04]    FLOAT (53)    NOT NULL,
    [S4Future05]    FLOAT (53)    NOT NULL,
    [S4Future06]    FLOAT (53)    NOT NULL,
    [S4Future07]    SMALLDATETIME NOT NULL,
    [S4Future08]    SMALLDATETIME NOT NULL,
    [S4Future09]    INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [SummPost]      CHAR (1)      NOT NULL,
    [UnitofMeas]    CHAR (6)      NOT NULL,
    [Units_SW]      CHAR (1)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [ValidateID]    CHAR (1)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [Account0] PRIMARY KEY CLUSTERED ([Acct] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Account1]
    ON [dbo].[Account]([CuryId] ASC, [Acct] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Account2]
    ON [dbo].[Account]([Descr] ASC, [Acct] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Account3]
    ON [dbo].[Account]([AcctType] ASC, [ClassID] ASC, [Acct] ASC) WITH (FILLFACTOR = 90);

