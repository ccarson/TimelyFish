CREATE TABLE [dbo].[Batch] (
    [Acct]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [AutoRev]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [AutoRevCopy]    SMALLINT      DEFAULT ((0)) NOT NULL,
    [BalanceType]    CHAR (1)      DEFAULT (' ') NOT NULL,
    [BankAcct]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [BankSub]        CHAR (24)     DEFAULT (' ') NOT NULL,
    [BaseCuryID]     CHAR (4)      DEFAULT (' ') NOT NULL,
    [BatNbr]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [BatType]        CHAR (1)      DEFAULT (' ') NOT NULL,
    [clearamt]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Cleared]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [CpnyID]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     DEFAULT (' ') NOT NULL,
    [CrTot]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CtrlTot]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryCrTot]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryCtrlTot]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryDepositAmt] FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryDrTot]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryEffDate]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [CuryId]         CHAR (4)      DEFAULT (' ') NOT NULL,
    [CuryMultDiv]    CHAR (1)      DEFAULT (' ') NOT NULL,
    [CuryRate]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryRateType]   CHAR (6)      DEFAULT (' ') NOT NULL,
    [Cycle]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [DateClr]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [DateEnt]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [DepositAmt]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Descr]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [DrTot]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [EditScrnNbr]    CHAR (5)      DEFAULT (' ') NOT NULL,
    [GLPostOpt]      CHAR (1)      DEFAULT (' ') NOT NULL,
    [JrnlType]       CHAR (3)      DEFAULT (' ') NOT NULL,
    [LedgerID]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     DEFAULT (' ') NOT NULL,
    [Module]         CHAR (2)      DEFAULT (' ') NOT NULL,
    [NbrCycle]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [NoteID]         INT           DEFAULT ((0)) NOT NULL,
    [OrigBatNbr]     CHAR (10)     DEFAULT (' ') NOT NULL,
    [OrigCpnyID]     CHAR (10)     DEFAULT (' ') NOT NULL,
    [OrigScrnNbr]    CHAR (5)      DEFAULT (' ') NOT NULL,
    [PerEnt]         CHAR (6)      DEFAULT (' ') NOT NULL,
    [PerPost]        CHAR (6)      DEFAULT (' ') NOT NULL,
    [Rlsed]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     DEFAULT (' ') NOT NULL,
    [Status]         CHAR (1)      DEFAULT (' ') NOT NULL,
    [Sub]            CHAR (24)     DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [VOBatNbrForPP]  CHAR (10)     DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [Batch0] PRIMARY KEY CLUSTERED ([Module] ASC, [BatNbr] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Batch12]
    ON [dbo].[Batch]([OrigScrnNbr] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [Batch13]
    ON [dbo].[Batch]([Module] ASC, [CpnyID] ASC, [BatNbr] ASC);


GO
CREATE NONCLUSTERED INDEX [Batch14]
    ON [dbo].[Batch]([CpnyID] ASC, [Module] ASC, [BatNbr] ASC, [Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [Batch2]
    ON [dbo].[Batch]([EditScrnNbr] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [Batch3]
    ON [dbo].[Batch]([Status] ASC, [Module] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [batch4]
    ON [dbo].[Batch]([Module] ASC, [Status] ASC, [PerPost] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [Batch5]
    ON [dbo].[Batch]([Module] ASC, [OrigBatNbr] ASC, [Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [Batch6]
    ON [dbo].[Batch]([BatNbr] ASC, [EditScrnNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [batch8]
    ON [dbo].[Batch]([Module] ASC, [BatType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [batch9]
    ON [dbo].[Batch]([CpnyID] ASC, [BatNbr] ASC, [EditScrnNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ADG_Batch1]
    ON [dbo].[Batch]([DateEnt] ASC, [Rlsed] ASC, [Status] ASC, [PerEnt] ASC, [PerPost] ASC, [Module] ASC, [JrnlType] ASC, [EditScrnNbr] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [Batch_Cash1]
    ON [dbo].[Batch]([CpnyID] ASC, [Module] ASC, [BankAcct] ASC, [BankSub] ASC, [Cleared] ASC, [DateClr] ASC);

