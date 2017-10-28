CREATE TABLE [dbo].[AllocDest] (
    [Acct]          CHAR (10)     NOT NULL,
    [AllocDest]     CHAR (10)     NOT NULL,
    [BasisAcct]     CHAR (10)     NOT NULL,
    [BasisCpnyID]   CHAR (10)     NOT NULL,
    [BasisSub]      CHAR (24)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DestFact]      FLOAT (53)    NOT NULL,
    [GrpId]         CHAR (6)      NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
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
    [Sub]           CHAR (24)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [AllocDest0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [GrpId] ASC, [Acct] ASC, [Sub] ASC, [BasisCpnyID] ASC, [BasisAcct] ASC, [BasisSub] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [AllocDest1]
    ON [dbo].[AllocDest]([Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [AllocDest2]
    ON [dbo].[AllocDest]([GrpId] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);

