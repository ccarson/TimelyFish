CREATE TABLE [dbo].[APDoc] (
    [Acct]           CHAR (10)     CONSTRAINT [DF_APDoc_Acct] DEFAULT (' ') NOT NULL,
    [AddlCost]       SMALLINT      CONSTRAINT [DF_APDoc_AddlCost] DEFAULT ((0)) NOT NULL,
    [ApplyAmt]       FLOAT (53)    CONSTRAINT [DF_APDoc_ApplyAmt] DEFAULT ((0)) NOT NULL,
    [ApplyDate]      SMALLDATETIME CONSTRAINT [DF_APDoc_ApplyDate] DEFAULT ('01/01/1900') NOT NULL,
    [ApplyRefNbr]    CHAR (10)     CONSTRAINT [DF_APDoc_ApplyRefNbr] DEFAULT (' ') NOT NULL,
    [BatNbr]         CHAR (10)     CONSTRAINT [DF_APDoc_BatNbr] DEFAULT (' ') NOT NULL,
    [BatSeq]         INT           CONSTRAINT [DF_APDoc_BatSeq] DEFAULT ((0)) NOT NULL,
    [BWAmt]          FLOAT (53)    CONSTRAINT [DF_APDoc_BWAmt] DEFAULT ((0)) NOT NULL,
    [CashAcct]       CHAR (10)     CONSTRAINT [DF_APDoc_CashAcct] DEFAULT (' ') NOT NULL,
    [CashSub]        CHAR (24)     CONSTRAINT [DF_APDoc_CashSub] DEFAULT (' ') NOT NULL,
    [ClearAmt]       FLOAT (53)    CONSTRAINT [DF_APDoc_ClearAmt] DEFAULT ((0)) NOT NULL,
    [ClearDate]      SMALLDATETIME CONSTRAINT [DF_APDoc_ClearDate] DEFAULT ('01/01/1900') NOT NULL,
    [CodeType]       CHAR (4)      DEFAULT ('HC') NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_APDoc_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_APDoc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_APDoc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_APDoc_Crtd_User] DEFAULT (' ') NOT NULL,
    [CurrentNbr]     SMALLINT      CONSTRAINT [DF_APDoc_CurrentNbr] DEFAULT ((0)) NOT NULL,
    [CuryBWAmt]      FLOAT (53)    CONSTRAINT [DF_APDoc_CuryBWAmt] DEFAULT ((0)) NOT NULL,
    [CuryDiscBal]    FLOAT (53)    CONSTRAINT [DF_APDoc_CuryDiscBal] DEFAULT ((0)) NOT NULL,
    [CuryDiscTkn]    FLOAT (53)    CONSTRAINT [DF_APDoc_CuryDiscTkn] DEFAULT ((0)) NOT NULL,
    [CuryDocBal]     FLOAT (53)    CONSTRAINT [DF_APDoc_CuryDocBal] DEFAULT ((0)) NOT NULL,
    [CuryEffDate]    SMALLDATETIME CONSTRAINT [DF_APDoc_CuryEffDate] DEFAULT ('01/01/1900') NOT NULL,
    [CuryId]         CHAR (4)      CONSTRAINT [DF_APDoc_CuryId] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]    CHAR (1)      CONSTRAINT [DF_APDoc_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryOrigDocAmt] FLOAT (53)    CONSTRAINT [DF_APDoc_CuryOrigDocAmt] DEFAULT ((0)) NOT NULL,
    [CuryPmtAmt]     FLOAT (53)    CONSTRAINT [DF_APDoc_CuryPmtAmt] DEFAULT ((0)) NOT NULL,
    [CuryRate]       FLOAT (53)    CONSTRAINT [DF_APDoc_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryRateType]   CHAR (6)      CONSTRAINT [DF_APDoc_CuryRateType] DEFAULT (' ') NOT NULL,
    [CuryTaxTot00]   FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTaxTot00] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot01]   FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTaxTot01] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot02]   FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTaxTot02] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot03]   FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTaxTot03] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot00]  FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTxblTot00] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot01]  FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTxblTot01] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot02]  FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTxblTot02] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot03]  FLOAT (53)    CONSTRAINT [DF_APDoc_CuryTxblTot03] DEFAULT ((0)) NOT NULL,
    [Cycle]          SMALLINT      CONSTRAINT [DF_APDoc_Cycle] DEFAULT ((0)) NOT NULL,
    [DfltDetail]     SMALLINT      CONSTRAINT [DF_APDoc_DfltDetail] DEFAULT ((0)) NOT NULL,
    [DirectDeposit]  CHAR (1)      CONSTRAINT [DF_APDoc_DirectDeposit] DEFAULT (' ') NOT NULL,
    [DiscBal]        FLOAT (53)    CONSTRAINT [DF_APDoc_DiscBal] DEFAULT ((0)) NOT NULL,
    [DiscDate]       SMALLDATETIME CONSTRAINT [DF_APDoc_DiscDate] DEFAULT ('01/01/1900') NOT NULL,
    [DiscTkn]        FLOAT (53)    CONSTRAINT [DF_APDoc_DiscTkn] DEFAULT ((0)) NOT NULL,
    [Doc1099]        SMALLINT      CONSTRAINT [DF_APDoc_Doc1099] DEFAULT ((0)) NOT NULL,
    [DocBal]         FLOAT (53)    CONSTRAINT [DF_APDoc_DocBal] DEFAULT ((0)) NOT NULL,
    [DocClass]       CHAR (1)      CONSTRAINT [DF_APDoc_DocClass] DEFAULT (' ') NOT NULL,
    [DocDate]        SMALLDATETIME CONSTRAINT [DF_APDoc_DocDate] DEFAULT ('01/01/1900') NOT NULL,
    [DocDesc]        CHAR (30)     CONSTRAINT [DF_APDoc_DocDesc] DEFAULT (' ') NOT NULL,
    [DocType]        CHAR (2)      CONSTRAINT [DF_APDoc_DocType] DEFAULT (' ') NOT NULL,
    [DueDate]        SMALLDATETIME CONSTRAINT [DF_APDoc_DueDate] DEFAULT ('01/01/1900') NOT NULL,
    [Econfirm]       CHAR (18)     CONSTRAINT [DF_APDoc_Econfirm] DEFAULT (' ') NOT NULL,
    [Estatus]        CHAR (1)      CONSTRAINT [DF_APDoc_Estatus] DEFAULT (' ') NOT NULL,
    [ExcludeFreight] CHAR (1)      CONSTRAINT [DF_APDoc_ExcludeFreight] DEFAULT (' ') NOT NULL,
    [FreightAmt]     FLOAT (53)    CONSTRAINT [DF_APDoc_FreightAmt] DEFAULT ((0)) NOT NULL,
    [InstallNbr]     SMALLINT      CONSTRAINT [DF_APDoc_InstallNbr] DEFAULT ((0)) NOT NULL,
    [InvcDate]       SMALLDATETIME CONSTRAINT [DF_APDoc_InvcDate] DEFAULT ('01/01/1900') NOT NULL,
    [InvcNbr]        CHAR (15)     CONSTRAINT [DF_APDoc_InvcNbr] DEFAULT (' ') NOT NULL,
    [LCCode]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [LineCntr]       INT           CONSTRAINT [DF_APDoc_LineCntr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_APDoc_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_APDoc_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_APDoc_LUpd_User] DEFAULT (' ') NOT NULL,
    [MasterDocNbr]   CHAR (10)     CONSTRAINT [DF_APDoc_MasterDocNbr] DEFAULT (' ') NOT NULL,
    [NbrCycle]       SMALLINT      CONSTRAINT [DF_APDoc_NbrCycle] DEFAULT ((0)) NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_APDoc_NoteID] DEFAULT ((0)) NOT NULL,
    [OpenDoc]        SMALLINT      CONSTRAINT [DF_APDoc_OpenDoc] DEFAULT ((0)) NOT NULL,
    [OrigDocAmt]     FLOAT (53)    CONSTRAINT [DF_APDoc_OrigDocAmt] DEFAULT ((0)) NOT NULL,
    [PayDate]        SMALLDATETIME CONSTRAINT [DF_APDoc_PayDate] DEFAULT ('01/01/1900') NOT NULL,
    [PayHoldDesc]    CHAR (30)     CONSTRAINT [DF_APDoc_PayHoldDesc] DEFAULT (' ') NOT NULL,
    [PC_Status]      CHAR (1)      CONSTRAINT [DF_APDoc_PC_Status] DEFAULT (' ') NOT NULL,
    [PerClosed]      CHAR (6)      CONSTRAINT [DF_APDoc_PerClosed] DEFAULT (' ') NOT NULL,
    [PerEnt]         CHAR (6)      CONSTRAINT [DF_APDoc_PerEnt] DEFAULT (' ') NOT NULL,
    [PerPost]        CHAR (6)      CONSTRAINT [DF_APDoc_PerPost] DEFAULT (' ') NOT NULL,
    [PmtAmt]         FLOAT (53)    CONSTRAINT [DF_APDoc_PmtAmt] DEFAULT ((0)) NOT NULL,
    [PmtID]          CHAR (10)     CONSTRAINT [DF_APDoc_PmtID] DEFAULT (' ') NOT NULL,
    [PmtMethod]      CHAR (1)      CONSTRAINT [DF_APDoc_PmtMethod] DEFAULT (' ') NOT NULL,
    [PONbr]          CHAR (10)     CONSTRAINT [DF_APDoc_PONbr] DEFAULT (' ') NOT NULL,
    [PrePay_RefNbr]  CHAR (10)     CONSTRAINT [DF_APDoc_PrePay_RefNbr] DEFAULT (' ') NOT NULL,
    [ProjectID]      CHAR (16)     CONSTRAINT [DF_APDoc_ProjectID] DEFAULT (' ') NOT NULL,
    [RecordID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RefNbr]         CHAR (10)     CONSTRAINT [DF_APDoc_RefNbr] DEFAULT (' ') NOT NULL,
    [Retention]      SMALLINT      CONSTRAINT [DF_APDoc_Retention] DEFAULT ((0)) NOT NULL,
    [RGOLAmt]        FLOAT (53)    CONSTRAINT [DF_APDoc_RGOLAmt] DEFAULT ((0)) NOT NULL,
    [Rlsed]          SMALLINT      CONSTRAINT [DF_APDoc_Rlsed] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_APDoc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_APDoc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_APDoc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_APDoc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_APDoc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_APDoc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_APDoc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_APDoc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_APDoc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_APDoc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_APDoc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_APDoc_S4Future12] DEFAULT (' ') NOT NULL,
    [Selected]       SMALLINT      CONSTRAINT [DF_APDoc_Selected] DEFAULT ((0)) NOT NULL,
    [Status]         CHAR (1)      CONSTRAINT [DF_APDoc_Status] DEFAULT (' ') NOT NULL,
    [Sub]            CHAR (24)     CONSTRAINT [DF_APDoc_Sub] DEFAULT (' ') NOT NULL,
    [Subcontract]    CHAR (16)     CONSTRAINT [DF_APDoc_Subcontract] DEFAULT (' ') NOT NULL,
    [TaxCntr00]      SMALLINT      CONSTRAINT [DF_APDoc_TaxCntr00] DEFAULT ((0)) NOT NULL,
    [TaxCntr01]      SMALLINT      CONSTRAINT [DF_APDoc_TaxCntr01] DEFAULT ((0)) NOT NULL,
    [TaxCntr02]      SMALLINT      CONSTRAINT [DF_APDoc_TaxCntr02] DEFAULT ((0)) NOT NULL,
    [TaxCntr03]      SMALLINT      CONSTRAINT [DF_APDoc_TaxCntr03] DEFAULT ((0)) NOT NULL,
    [TaxId00]        CHAR (10)     CONSTRAINT [DF_APDoc_TaxId00] DEFAULT (' ') NOT NULL,
    [TaxId01]        CHAR (10)     CONSTRAINT [DF_APDoc_TaxId01] DEFAULT (' ') NOT NULL,
    [TaxId02]        CHAR (10)     CONSTRAINT [DF_APDoc_TaxId02] DEFAULT (' ') NOT NULL,
    [TaxId03]        CHAR (10)     CONSTRAINT [DF_APDoc_TaxId03] DEFAULT (' ') NOT NULL,
    [TaxTot00]       FLOAT (53)    CONSTRAINT [DF_APDoc_TaxTot00] DEFAULT ((0)) NOT NULL,
    [TaxTot01]       FLOAT (53)    CONSTRAINT [DF_APDoc_TaxTot01] DEFAULT ((0)) NOT NULL,
    [TaxTot02]       FLOAT (53)    CONSTRAINT [DF_APDoc_TaxTot02] DEFAULT ((0)) NOT NULL,
    [TaxTot03]       FLOAT (53)    CONSTRAINT [DF_APDoc_TaxTot03] DEFAULT ((0)) NOT NULL,
    [Terms]          CHAR (2)      CONSTRAINT [DF_APDoc_Terms] DEFAULT (' ') NOT NULL,
    [TxblTot00]      FLOAT (53)    CONSTRAINT [DF_APDoc_TxblTot00] DEFAULT ((0)) NOT NULL,
    [TxblTot01]      FLOAT (53)    CONSTRAINT [DF_APDoc_TxblTot01] DEFAULT ((0)) NOT NULL,
    [TxblTot02]      FLOAT (53)    CONSTRAINT [DF_APDoc_TxblTot02] DEFAULT ((0)) NOT NULL,
    [TxblTot03]      FLOAT (53)    CONSTRAINT [DF_APDoc_TxblTot03] DEFAULT ((0)) NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_APDoc_User1] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_APDoc_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_APDoc_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_APDoc_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_APDoc_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_APDoc_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_APDoc_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_APDoc_User8] DEFAULT ('01/01/1900') NOT NULL,
    [VendId]         CHAR (15)     CONSTRAINT [DF_APDoc_VendId] DEFAULT (' ') NOT NULL,
    [VendName]       CHAR (60)     CONSTRAINT [DF_APDoc_VendName] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [APDoc0] PRIMARY KEY CLUSTERED ([Acct] ASC, [Sub] ASC, [DocType] ASC, [RefNbr] ASC, [RecordID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [APDoc1]
    ON [dbo].[APDoc]([RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc10]
    ON [dbo].[APDoc]([VendId] ASC, [PerPost] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc11]
    ON [dbo].[APDoc]([DocClass] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc12]
    ON [dbo].[APDoc]([InvcNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc13]
    ON [dbo].[APDoc]([BatNbr] ASC, [Acct] ASC, [Sub] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc14]
    ON [dbo].[APDoc]([VendId] ASC, [DocClass] ASC, [Rlsed] ASC, [BatNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc15]
    ON [dbo].[APDoc]([OpenDoc] ASC, [Rlsed] ASC, [Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc18]
    ON [dbo].[APDoc]([PONbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc20]
    ON [dbo].[APDoc]([DocClass] ASC, [Acct] ASC, [Sub] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc21]
    ON [dbo].[APDoc]([VendId] ASC, [CpnyID] ASC, [DocClass] ASC, [Rlsed] ASC, [BatNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc22]
    ON [dbo].[APDoc]([Status] ASC, [VendId] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc23]
    ON [dbo].[APDoc]([Terms] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc24]
    ON [dbo].[APDoc]([BatNbr] ASC, [ApplyRefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc3]
    ON [dbo].[APDoc]([DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc4]
    ON [dbo].[APDoc]([VendId] ASC, [DocClass] ASC, [DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc5]
    ON [dbo].[APDoc]([ApplyRefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc6]
    ON [dbo].[APDoc]([BatNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc7]
    ON [dbo].[APDoc]([VendId] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APDoc9]
    ON [dbo].[APDoc]([VendId] ASC, [DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);

