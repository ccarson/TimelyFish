CREATE TABLE [dbo].[BankRec] (
    [BankAcct]           CHAR (10)     NOT NULL,
    [BankSub]            CHAR (24)     NOT NULL,
    [CpnyID]             CHAR (10)     NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [CuryDepInTransit]   FLOAT (53)    NOT NULL,
    [CuryOutstandingChk] FLOAT (53)    NOT NULL,
    [CuryStmtbal]        FLOAT (53)    NOT NULL,
    [DepInTransit]       FLOAT (53)    NOT NULL,
    [GLPeriod]           CHAR (6)      NOT NULL,
    [LastReconDate]      SMALLDATETIME NOT NULL,
    [LUpd_DateTime]      SMALLDATETIME NOT NULL,
    [LUpd_Prog]          CHAR (8)      NOT NULL,
    [LUpd_User]          CHAR (10)     NOT NULL,
    [NoteID]             INT           NOT NULL,
    [OutStandingChk]     FLOAT (53)    NOT NULL,
    [ReconcileFlag]      SMALLINT      NOT NULL,
    [ReconDate]          SMALLDATETIME NOT NULL,
    [S4Future01]         CHAR (30)     NOT NULL,
    [S4Future02]         CHAR (30)     NOT NULL,
    [S4Future03]         FLOAT (53)    NOT NULL,
    [S4Future04]         FLOAT (53)    NOT NULL,
    [S4Future05]         FLOAT (53)    NOT NULL,
    [S4Future06]         FLOAT (53)    NOT NULL,
    [S4Future07]         SMALLDATETIME NOT NULL,
    [S4Future08]         SMALLDATETIME NOT NULL,
    [S4Future09]         INT           NOT NULL,
    [S4Future10]         INT           NOT NULL,
    [S4Future11]         CHAR (10)     NOT NULL,
    [S4Future12]         CHAR (10)     NOT NULL,
    [StmtBal]            FLOAT (53)    NOT NULL,
    [StmtDate]           SMALLDATETIME NOT NULL,
    [User1]              CHAR (30)     NOT NULL,
    [User2]              CHAR (30)     NOT NULL,
    [User3]              FLOAT (53)    NOT NULL,
    [User4]              FLOAT (53)    NOT NULL,
    [User5]              CHAR (10)     NOT NULL,
    [User6]              CHAR (10)     NOT NULL,
    [User7]              SMALLDATETIME NOT NULL,
    [User8]              SMALLDATETIME NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [BankRec0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [BankAcct] ASC, [BankSub] ASC, [StmtDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [BankRec1]
    ON [dbo].[BankRec]([StmtDate] ASC, [CpnyID] ASC, [BankAcct] ASC, [BankSub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [BankRec3]
    ON [dbo].[BankRec]([ReconDate] ASC, [CpnyID] ASC, [BankAcct] ASC, [BankSub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [BankRec4]
    ON [dbo].[BankRec]([CpnyID] ASC, [BankAcct] ASC, [BankSub] ASC, [ReconDate] ASC) WITH (FILLFACTOR = 90);

