CREATE TABLE [dbo].[APTran] (
    [Acct]             CHAR (10)     NOT NULL,
    [AcctDist]         SMALLINT      NOT NULL,
    [AlternateID]      CHAR (30)     NOT NULL,
    [Applied_PPRefNbr] CHAR (10)     NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [BOMLineRef]       CHAR (5)      NOT NULL,
    [BoxNbr]           CHAR (2)      NOT NULL,
    [Component]        CHAR (30)     NOT NULL,
    [CostType]         CHAR (8)      NOT NULL,
    [CostTypeWO]       CHAR (2)      NOT NULL,
    [CpnyID]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [CuryId]           CHAR (4)      NOT NULL,
    [CuryMultDiv]      CHAR (1)      NOT NULL,
    [CuryPOExtPrice]   FLOAT (53)    NOT NULL,
    [CuryPOUnitPrice]  FLOAT (53)    NOT NULL,
    [CuryPPV]          FLOAT (53)    NOT NULL,
    [CuryRate]         FLOAT (53)    NOT NULL,
    [CuryTaxAmt00]     FLOAT (53)    NOT NULL,
    [CuryTaxAmt01]     FLOAT (53)    NOT NULL,
    [CuryTaxAmt02]     FLOAT (53)    NOT NULL,
    [CuryTaxAmt03]     FLOAT (53)    NOT NULL,
    [CuryTranAmt]      FLOAT (53)    NOT NULL,
    [CuryTxblAmt00]    FLOAT (53)    NOT NULL,
    [CuryTxblAmt01]    FLOAT (53)    NOT NULL,
    [CuryTxblAmt02]    FLOAT (53)    NOT NULL,
    [CuryTxblAmt03]    FLOAT (53)    NOT NULL,
    [CuryUnitPrice]    FLOAT (53)    NOT NULL,
    [DrCr]             CHAR (1)      NOT NULL,
    [Employee]         CHAR (10)     NOT NULL,
    [EmployeeID]       CHAR (10)     NOT NULL,
    [Excpt]            SMALLINT      NOT NULL,
    [ExtRefNbr]        CHAR (15)     NOT NULL,
    [FiscYr]           CHAR (4)      NOT NULL,
    [InstallNbr]       SMALLINT      NOT NULL,
    [InvcTypeID]       CHAR (10)     NOT NULL,
    [InvtID]           CHAR (30)     NOT NULL,
    [JobRate]          FLOAT (53)    NOT NULL,
    [JrnlType]         CHAR (3)      NOT NULL,
    [Labor_Class_Cd]   CHAR (4)      NOT NULL,
    [LCCode]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [LineId]           INT           NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [LineRef]          CHAR (5)      NOT NULL,
    [LineType]         CHAR (1)      NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [MasterDocNbr]     CHAR (10)     NOT NULL,
    [NoteID]           INT           NOT NULL,
    [PC_Flag]          CHAR (1)      NOT NULL,
    [PC_ID]            CHAR (20)     NOT NULL,
    [PC_Status]        CHAR (1)      NOT NULL,
    [PerEnt]           CHAR (6)      NOT NULL,
    [PerPost]          CHAR (6)      NOT NULL,
    [PmtMethod]        CHAR (1)      NOT NULL,
    [POExtPrice]       FLOAT (53)    NOT NULL,
    [POLineRef]        CHAR (5)      NOT NULL,
    [PONbr]            CHAR (10)     NOT NULL,
    [POQty]            FLOAT (53)    NOT NULL,
    [POUnitPrice]      FLOAT (53)    NOT NULL,
    [PPV]              FLOAT (53)    NOT NULL,
    [ProjectID]        CHAR (16)     NOT NULL,
    [Qty]              FLOAT (53)    NOT NULL,
    [QtyVar]           FLOAT (53)    NOT NULL,
    [RcptLineRef]      CHAR (5)      NOT NULL,
    [RcptNbr]          CHAR (10)     NOT NULL,
    [RcptQty]          FLOAT (53)    NOT NULL,
    [RecordID]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RefNbr]           CHAR (10)     NOT NULL,
    [Rlsed]            SMALLINT      NOT NULL,
    [S4Future01]       CHAR (30)     NOT NULL,
    [S4Future02]       CHAR (30)     NOT NULL,
    [S4Future03]       FLOAT (53)    NOT NULL,
    [S4Future04]       FLOAT (53)    NOT NULL,
    [S4Future05]       FLOAT (53)    NOT NULL,
    [S4Future06]       FLOAT (53)    NOT NULL,
    [S4Future07]       SMALLDATETIME NOT NULL,
    [S4Future08]       SMALLDATETIME NOT NULL,
    [S4Future09]       INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [ServiceDate]      SMALLDATETIME NOT NULL,
    [SiteId]           CHAR (10)     NOT NULL,
    [SoLineRef]        CHAR (5)      NOT NULL,
    [SOOrdNbr]         CHAR (15)     NOT NULL,
    [SOTypeID]         CHAR (4)      NOT NULL,
    [Sub]              CHAR (24)     NOT NULL,
    [TaskID]           CHAR (32)     NOT NULL,
    [TaxAmt00]         FLOAT (53)    NOT NULL,
    [TaxAmt01]         FLOAT (53)    NOT NULL,
    [TaxAmt02]         FLOAT (53)    NOT NULL,
    [TaxAmt03]         FLOAT (53)    NOT NULL,
    [TaxCalced]        CHAR (1)      NOT NULL,
    [TaxCat]           CHAR (10)     NOT NULL,
    [TaxId00]          CHAR (10)     NOT NULL,
    [TaxId01]          CHAR (10)     NOT NULL,
    [TaxId02]          CHAR (10)     NOT NULL,
    [TaxId03]          CHAR (10)     NOT NULL,
    [TaxIdDflt]        CHAR (10)     NOT NULL,
    [TranAmt]          FLOAT (53)    NOT NULL,
    [TranClass]        CHAR (1)      NOT NULL,
    [TranDate]         SMALLDATETIME NOT NULL,
    [TranDesc]         CHAR (30)     NOT NULL,
    [trantype]         CHAR (2)      NOT NULL,
    [TxblAmt00]        FLOAT (53)    NOT NULL,
    [TxblAmt01]        FLOAT (53)    NOT NULL,
    [TxblAmt02]        FLOAT (53)    NOT NULL,
    [TxblAmt03]        FLOAT (53)    NOT NULL,
    [UnitDesc]         CHAR (10)     NOT NULL,
    [UnitPrice]        FLOAT (53)    NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [VendId]           CHAR (15)     NOT NULL,
    [WONbr]            CHAR (10)     NOT NULL,
    [WOStepNbr]        CHAR (5)      NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [APTran0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [Acct] ASC, [Sub] ASC, [RefNbr] ASC, [RecordID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [APTran10]
    ON [dbo].[APTran]([RcptNbr] ASC, [Rlsed] ASC, [PONbr] ASC, [RcptLineRef] ASC);


GO
CREATE NONCLUSTERED INDEX [APTran2]
    ON [dbo].[APTran]([UnitDesc] ASC, [CostType] ASC);


GO
CREATE NONCLUSTERED INDEX [APTran3]
    ON [dbo].[APTran]([BatNbr] ASC, [RefNbr] ASC);


GO
CREATE NONCLUSTERED INDEX [APTran4]
    ON [dbo].[APTran]([BatNbr] ASC, [LineNbr] ASC);


GO
CREATE NONCLUSTERED INDEX [APTran5]
    ON [dbo].[APTran]([RefNbr] ASC, [trantype] ASC, [LineNbr] ASC);


GO
CREATE NONCLUSTERED INDEX [APTran6]
    ON [dbo].[APTran]([Acct] ASC, [Sub] ASC, [RefNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APTran8]
    ON [dbo].[APTran]([VendId] ASC, [ExtRefNbr] ASC, [UnitDesc] ASC, [CostType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APTran9]
    ON [dbo].[APTran]([PONbr] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [APTran99]
    ON [dbo].[APTran]([RecordID] ASC);


GO
CREATE NONCLUSTERED INDEX [BR_APTran1]
    ON [dbo].[APTran]([PerPost] ASC, [Acct] ASC, [Sub] ASC);


GO
CREATE NONCLUSTERED INDEX [aptran_spot]
    ON [dbo].[APTran]([PC_Status] ASC, [Rlsed] ASC, [JrnlType] ASC);


GO
CREATE NONCLUSTERED INDEX [aptran_stran]
    ON [dbo].[APTran]([PerPost] ASC, [Rlsed] ASC, [PC_Status] ASC);


GO
CREATE NONCLUSTERED INDEX [APTran_x11]
    ON [dbo].[APTran]([trantype] ASC)
    INCLUDE([Acct], [BatNbr], [RecordID], [RefNbr], [Sub], [TranAmt]);


GO
CREATE NONCLUSTERED INDEX [IX_APTran_PaperSave]
    ON [dbo].[APTran]([Crtd_DateTime] ASC)
    INCLUDE([BatNbr], [VendId], [Crtd_Prog], [ExtRefNbr], [PONbr], [RefNbr], [TranAmt], [TranDate]);

