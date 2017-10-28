CREATE TABLE [dbo].[ARDoc] (
    [AcctNbr]         CHAR (30)     NOT NULL,
    [AgentID]         CHAR (10)     NOT NULL,
    [ApplAmt]         FLOAT (53)    NOT NULL,
    [ApplBatNbr]      CHAR (10)     NOT NULL,
    [ApplBatSeq]      INT           NOT NULL,
    [ASID]            INT           NOT NULL,
    [BankAcct]        CHAR (10)     NOT NULL,
    [BankID]          CHAR (10)     NOT NULL,
    [BankSub]         CHAR (24)     NOT NULL,
    [BatNbr]          CHAR (10)     NOT NULL,
    [BatSeq]          INT           NOT NULL,
    [Cleardate]       SMALLDATETIME NOT NULL,
    [CmmnAmt]         FLOAT (53)    NOT NULL,
    [CmmnPct]         FLOAT (53)    NOT NULL,
    [ContractID]      CHAR (10)     NOT NULL,
    [CpnyID]          CHAR (10)     NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [CurrentNbr]      SMALLINT      NOT NULL,
    [CuryApplAmt]     FLOAT (53)    NOT NULL,
    [CuryClearAmt]    FLOAT (53)    NOT NULL,
    [CuryCmmnAmt]     FLOAT (53)    NOT NULL,
    [CuryDiscApplAmt] FLOAT (53)    NOT NULL,
    [CuryDiscBal]     FLOAT (53)    NOT NULL,
    [CuryDocBal]      FLOAT (53)    NOT NULL,
    [CuryEffDate]     SMALLDATETIME NOT NULL,
    [CuryId]          CHAR (4)      NOT NULL,
    [CuryMultDiv]     CHAR (1)      NOT NULL,
    [CuryOrigDocAmt]  FLOAT (53)    NOT NULL,
    [CuryRate]        FLOAT (53)    NOT NULL,
    [CuryRateType]    CHAR (6)      NOT NULL,
    [CuryStmtBal]     FLOAT (53)    NOT NULL,
    [CuryTaxTot00]    FLOAT (53)    NOT NULL,
    [CuryTaxTot01]    FLOAT (53)    NOT NULL,
    [CuryTaxTot02]    FLOAT (53)    NOT NULL,
    [CuryTaxTot03]    FLOAT (53)    NOT NULL,
    [CuryTxblTot00]   FLOAT (53)    NOT NULL,
    [CuryTxblTot01]   FLOAT (53)    NOT NULL,
    [CuryTxblTot02]   FLOAT (53)    NOT NULL,
    [CuryTxblTot03]   FLOAT (53)    NOT NULL,
    [CustId]          CHAR (15)     NOT NULL,
    [CustOrdNbr]      CHAR (25)     NOT NULL,
    [Cycle]           SMALLINT      NOT NULL,
    [DiscApplAmt]     FLOAT (53)    NOT NULL,
    [DiscBal]         FLOAT (53)    NOT NULL,
    [DiscDate]        SMALLDATETIME NOT NULL,
    [DocBal]          FLOAT (53)    NOT NULL,
    [DocClass]        CHAR (1)      NOT NULL,
    [DocDate]         SMALLDATETIME NOT NULL,
    [DocDesc]         CHAR (30)     NOT NULL,
    [DocType]         CHAR (2)      NOT NULL,
    [DraftIssued]     SMALLINT      NOT NULL,
    [DueDate]         SMALLDATETIME NOT NULL,
    [InstallNbr]      SMALLINT      NOT NULL,
    [JobCntr]         SMALLINT      NOT NULL,
    [LineCntr]        INT           NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [MasterDocNbr]    CHAR (10)     NOT NULL,
    [NbrCycle]        SMALLINT      NOT NULL,
    [NoPrtStmt]       SMALLINT      NOT NULL,
    [NoteId]          INT           NOT NULL,
    [OpenDoc]         SMALLINT      NOT NULL,
    [OrdNbr]          CHAR (15)     NOT NULL,
    [OrigBankAcct]    CHAR (10)     NOT NULL,
    [OrigBankSub]     CHAR (24)     NOT NULL,
    [OrigCpnyID]      CHAR (10)     NOT NULL,
    [OrigDocAmt]      FLOAT (53)    NOT NULL,
    [OrigDocNbr]      CHAR (10)     NOT NULL,
    [PC_Status]       CHAR (1)      NOT NULL,
    [PerClosed]       CHAR (6)      NOT NULL,
    [PerEnt]          CHAR (6)      NOT NULL,
    [PerPost]         CHAR (6)      NOT NULL,
    [PmtMethod]       CHAR (1)      NOT NULL,
    [ProjectID]       CHAR (16)     NOT NULL,
    [RefNbr]          CHAR (10)     NOT NULL,
    [RGOLAmt]         FLOAT (53)    NOT NULL,
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
    [ServiceCallID]   CHAR (10)     NOT NULL,
    [ShipmentNbr]     SMALLINT      NOT NULL,
    [SlsperId]        CHAR (10)     NOT NULL,
    [Status]          CHAR (1)      NOT NULL,
    [StmtBal]         FLOAT (53)    NOT NULL,
    [StmtDate]        SMALLDATETIME NOT NULL,
    [TaskID]          CHAR (32)     NOT NULL,
    [TaxCntr00]       SMALLINT      NOT NULL,
    [TaxCntr01]       SMALLINT      NOT NULL,
    [TaxCntr02]       SMALLINT      NOT NULL,
    [TaxCntr03]       SMALLINT      NOT NULL,
    [TaxId00]         CHAR (10)     NOT NULL,
    [TaxId01]         CHAR (10)     NOT NULL,
    [TaxId02]         CHAR (10)     NOT NULL,
    [TaxId03]         CHAR (10)     NOT NULL,
    [TaxTot00]        FLOAT (53)    NOT NULL,
    [TaxTot01]        FLOAT (53)    NOT NULL,
    [TaxTot02]        FLOAT (53)    NOT NULL,
    [TaxTot03]        FLOAT (53)    NOT NULL,
    [Terms]           CHAR (2)      NOT NULL,
    [TxblTot00]       FLOAT (53)    NOT NULL,
    [TxblTot01]       FLOAT (53)    NOT NULL,
    [TxblTot02]       FLOAT (53)    NOT NULL,
    [TxblTot03]       FLOAT (53)    NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [WSID]            INT           NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [ARDoc0] PRIMARY KEY CLUSTERED ([CustId] ASC, [DocType] ASC, [RefNbr] ASC, [BatNbr] ASC, [BatSeq] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [ARDoc1]
    ON [dbo].[ARDoc]([DocClass] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc2]
    ON [dbo].[ARDoc]([RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc3]
    ON [dbo].[ARDoc]([DocDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc4]
    ON [dbo].[ARDoc]([CustId] ASC, [RefNbr] ASC, [BatNbr] ASC, [Rlsed] ASC, [CpnyID] ASC, [DocType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc5]
    ON [dbo].[ARDoc]([CustId] ASC, [DocBal] ASC, [DocDate] ASC, [Rlsed] ASC, [Terms] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc6]
    ON [dbo].[ARDoc]([CustId] ASC, [DocClass] ASC, [DocDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc7]
    ON [dbo].[ARDoc]([CustId] ASC, [DocDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc8]
    ON [dbo].[ARDoc]([BatNbr] ASC, [CustId] ASC, [DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc9]
    ON [dbo].[ARDoc]([PerClosed] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc10]
    ON [dbo].[ARDoc]([BatNbr] ASC, [BatSeq] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc11]
    ON [dbo].[ARDoc]([CustId] ASC, [Rlsed] ASC, [DueDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc12]
    ON [dbo].[ARDoc]([CustId] ASC, [PerPost] ASC, [Rlsed] ASC, [DocClass] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc13]
    ON [dbo].[ARDoc]([ApplBatNbr] ASC, [ApplBatSeq] ASC, [BatNbr] ASC, [BatSeq] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc14]
    ON [dbo].[ARDoc]([CuryId] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc15]
    ON [dbo].[ARDoc]([ApplBatNbr] ASC, [CuryId] ASC, [ApplBatSeq] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc16]
    ON [dbo].[ARDoc]([DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc17]
    ON [dbo].[ARDoc]([ApplBatNbr] ASC, [CustId] ASC, [DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc18]
    ON [dbo].[ARDoc]([CpnyID] ASC, [CustId] ASC, [DocType] ASC, [RefNbr] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARDoc19]
    ON [dbo].[ARDoc]([BatNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ardoc_stran]
    ON [dbo].[ARDoc]([PerPost] ASC, [Rlsed] ASC, [PC_Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ardoc_proj]
    ON [dbo].[ARDoc]([ProjectID] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 100);

