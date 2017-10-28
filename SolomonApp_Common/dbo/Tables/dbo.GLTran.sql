CREATE TABLE [dbo].[GLTran] (
    [Acct]            CHAR (10)     NOT NULL,
    [AppliedDate]     SMALLDATETIME NOT NULL,
    [BalanceType]     CHAR (1)      NOT NULL,
    [BaseCuryID]      CHAR (4)      NOT NULL,
    [BatNbr]          CHAR (10)     NOT NULL,
    [CpnyID]          CHAR (10)     NOT NULL,
    [CrAmt]           FLOAT (53)    NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [CuryCrAmt]       FLOAT (53)    NOT NULL,
    [CuryDrAmt]       FLOAT (53)    NOT NULL,
    [CuryEffDate]     SMALLDATETIME NOT NULL,
    [CuryId]          CHAR (4)      NOT NULL,
    [CuryMultDiv]     CHAR (1)      NOT NULL,
    [CuryRate]        FLOAT (53)    NOT NULL,
    [CuryRateType]    CHAR (6)      NOT NULL,
    [DrAmt]           FLOAT (53)    NOT NULL,
    [EmployeeID]      CHAR (10)     NOT NULL,
    [ExtRefNbr]       CHAR (15)     NOT NULL,
    [FiscYr]          CHAR (4)      NOT NULL,
    [IC_Distribution] SMALLINT      NOT NULL,
    [Id]              CHAR (20)     NOT NULL,
    [JrnlType]        CHAR (3)      NOT NULL,
    [Labor_Class_Cd]  CHAR (4)      NOT NULL,
    [LedgerID]        CHAR (10)     NOT NULL,
    [LineId]          INT           NOT NULL,
    [LineNbr]         SMALLINT      NOT NULL,
    [LineRef]         CHAR (5)      NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [Module]          CHAR (2)      NOT NULL,
    [NoteID]          INT           NOT NULL,
    [OrigAcct]        CHAR (10)     NOT NULL,
    [OrigBatNbr]      CHAR (10)     NOT NULL,
    [OrigCpnyID]      CHAR (10)     NOT NULL,
    [OrigSub]         CHAR (24)     NOT NULL,
    [PC_Flag]         CHAR (1)      NOT NULL,
    [PC_ID]           CHAR (20)     NOT NULL,
    [PC_Status]       CHAR (1)      NOT NULL,
    [PerEnt]          CHAR (6)      NOT NULL,
    [PerPost]         CHAR (6)      NOT NULL,
    [Posted]          CHAR (1)      NOT NULL,
    [ProjectID]       CHAR (16)     NOT NULL,
    [Qty]             FLOAT (53)    NOT NULL,
    [RefNbr]          CHAR (10)     NOT NULL,
    [RevEntryOption]  CHAR (1)      NOT NULL,
    [Rlsed]           SMALLINT      NOT NULL,
    [S4Future01]      CHAR (30)     NOT NULL,
    [S4Future02]      CHAR (30)     NOT NULL,
    [S4Future03]      FLOAT (53)    NOT NULL,
    [S4Future04]      FLOAT (53)    NOT NULL,
    [S4Future05]      FLOAT (53)    NOT NULL,
    [S4Future06]      FLOAT (53)    NOT NULL,
    [S4Future07]      SMALLDATETIME NOT NULL,
    [S4Future08]      SMALLDATETIME NOT NULL,
    [S4Future09]      INT           NOT NULL,
    [S4Future10]      INT           NOT NULL,
    [S4Future11]      CHAR (10)     NOT NULL,
    [S4Future12]      CHAR (10)     NOT NULL,
    [ServiceDate]     SMALLDATETIME NOT NULL,
    [Sub]             CHAR (24)     NOT NULL,
    [TaskID]          CHAR (32)     NOT NULL,
    [TranDate]        SMALLDATETIME NOT NULL,
    [TranDesc]        CHAR (30)     NOT NULL,
    [TranType]        CHAR (2)      NOT NULL,
    [Units]           FLOAT (53)    NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [GLTran0] PRIMARY KEY CLUSTERED ([Module] ASC, [BatNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [GLTran1]
    ON [dbo].[GLTran]([Module] ASC, [BatNbr] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran2]
    ON [dbo].[GLTran]([PerEnt] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran3]
    ON [dbo].[GLTran]([Posted] ASC, [Acct] ASC, [Sub] ASC, [LedgerID] ASC, [PerPost] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran4]
    ON [dbo].[GLTran]([Module] ASC, [Posted] ASC, [PerPost] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran5]
    ON [dbo].[GLTran]([Posted] ASC, [PerEnt] ASC, [JrnlType] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran6]
    ON [dbo].[GLTran]([Acct] ASC, [Sub] ASC, [LedgerID] ASC, [FiscYr] ASC, [PerPost] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran7]
    ON [dbo].[GLTran]([Acct] ASC, [Sub] ASC, [LedgerID] ASC, [FiscYr] ASC, [Posted] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran8]
    ON [dbo].[GLTran]([LedgerID] ASC, [Acct] ASC, [Sub] ASC, [FiscYr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran9]
    ON [dbo].[GLTran]([IC_Distribution] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [GLTran10]
    ON [dbo].[GLTran]([Acct] ASC, [Sub] ASC, [CpnyID] ASC, [BatNbr] ASC, [RefNbr] ASC, [BaseCuryID] ASC, [TranType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [gltran_stran]
    ON [dbo].[GLTran]([PerPost] ASC, [Rlsed] ASC, [PC_Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [BR_GLTran1]
    ON [dbo].[GLTran]([Module] ASC, [PerPost] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_GLTran_crtd_datetime_incl]
    ON [dbo].[GLTran]([Crtd_DateTime] ASC)
    INCLUDE([tstamp], [BatNbr], [CrAmt], [DrAmt], [Module], [TranDate]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx2_GLTran_crtd_datetime_incl]
    ON [dbo].[GLTran]([Crtd_DateTime] ASC)
    INCLUDE([Acct], [BatNbr], [LineNbr], [Module], [tstamp]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_GLTran_uqry_checks]
    ON [dbo].[GLTran]([TaskID] ASC)
    INCLUDE([Acct], [BatNbr], [DrAmt], [Id], [RefNbr], [Sub], [TranDesc]) WITH (FILLFACTOR = 100);

