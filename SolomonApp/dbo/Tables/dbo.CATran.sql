CREATE TABLE [dbo].[CATran] (
    [Acct]           CHAR (10)     NOT NULL,
    [AcctDist]       SMALLINT      NOT NULL,
    [bankacct]       CHAR (10)     NOT NULL,
    [BankCpnyID]     CHAR (10)     NOT NULL,
    [banksub]        CHAR (24)     NOT NULL,
    [batnbr]         CHAR (10)     NOT NULL,
    [ClearAmt]       FLOAT (53)    NOT NULL,
    [ClearDate]      SMALLDATETIME NOT NULL,
    [CpnyID]         CHAR (10)     NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [CuryID]         CHAR (4)      NOT NULL,
    [CuryMultDiv]    CHAR (1)      NOT NULL,
    [CuryRate]       FLOAT (53)    NOT NULL,
    [curytranamt]    FLOAT (53)    NOT NULL,
    [DrCr]           CHAR (1)      NOT NULL,
    [EmployeeID]     CHAR (10)     NOT NULL,
    [EntryId]        CHAR (2)      NOT NULL,
    [JrnlType]       CHAR (3)      NOT NULL,
    [Labor_Class_Cd] CHAR (4)      NOT NULL,
    [LineID]         INT           NOT NULL,
    [Linenbr]        SMALLINT      NOT NULL,
    [LineRef]        CHAR (5)      NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME NOT NULL,
    [LUpd_Prog]      CHAR (8)      NOT NULL,
    [LUpd_User]      CHAR (10)     NOT NULL,
    [Module]         CHAR (2)      NOT NULL,
    [NoteID]         INT           NOT NULL,
    [PayeeID]        CHAR (15)     NOT NULL,
    [PC_Flag]        CHAR (1)      NOT NULL,
    [PC_ID]          CHAR (20)     NOT NULL,
    [PC_Status]      CHAR (1)      NOT NULL,
    [PerClosed]      CHAR (6)      NOT NULL,
    [Perent]         CHAR (6)      NOT NULL,
    [PerPost]        CHAR (6)      NOT NULL,
    [ProjectID]      CHAR (16)     NOT NULL,
    [Qty]            FLOAT (53)    NOT NULL,
    [RcnclStatus]    CHAR (1)      NOT NULL,
    [RecurId]        CHAR (10)     NOT NULL,
    [RefNbr]         CHAR (10)     NOT NULL,
    [Rlsed]          SMALLINT      NOT NULL,
    [S4Future01]     CHAR (30)     NOT NULL,
    [S4Future02]     CHAR (30)     NOT NULL,
    [S4Future03]     FLOAT (53)    NOT NULL,
    [S4Future04]     FLOAT (53)    NOT NULL,
    [S4Future05]     FLOAT (53)    NOT NULL,
    [S4Future06]     FLOAT (53)    NOT NULL,
    [S4Future07]     SMALLDATETIME NOT NULL,
    [S4Future08]     SMALLDATETIME NOT NULL,
    [S4Future09]     INT           NOT NULL,
    [S4Future10]     INT           NOT NULL,
    [S4Future11]     CHAR (10)     NOT NULL,
    [S4Future12]     CHAR (10)     NOT NULL,
    [Sub]            CHAR (24)     NOT NULL,
    [TaskID]         CHAR (32)     NOT NULL,
    [TranAmt]        FLOAT (53)    NOT NULL,
    [TranDate]       SMALLDATETIME NOT NULL,
    [TranDesc]       CHAR (30)     NOT NULL,
    [trsftobankacct] CHAR (10)     NOT NULL,
    [trsftobanksub]  CHAR (24)     NOT NULL,
    [TrsfToCpnyID]   CHAR (10)     NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [CATran0] PRIMARY KEY CLUSTERED ([Module] ASC, [batnbr] ASC, [Linenbr] ASC, [BankCpnyID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [CATran1]
    ON [dbo].[CATran]([Module] ASC, [batnbr] ASC, [CpnyID] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [CATran2]
    ON [dbo].[CATran]([Perent] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [CATran3]
    ON [dbo].[CATran]([CpnyID] ASC, [bankacct] ASC, [banksub] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [CAtran4]
    ON [dbo].[CATran]([RecurId] ASC, [Linenbr] ASC, [BankCpnyID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [CATran5]
    ON [dbo].[CATran]([Module] ASC, [RefNbr] ASC, [batnbr] ASC, [Linenbr] ASC, [BankCpnyID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [CATran7]
    ON [dbo].[CATran]([CpnyID] ASC, [bankacct] ASC, [banksub] ASC, [TranDate] ASC, [batnbr] ASC, [EntryId] ASC) WITH (FILLFACTOR = 100);

