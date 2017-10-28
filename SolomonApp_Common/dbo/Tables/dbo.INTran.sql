CREATE TABLE [dbo].[INTran] (
    [Acct]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [AcctDist]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [ARDocType]        CHAR (2)      DEFAULT (' ') NOT NULL,
    [ARLineID]         INT           DEFAULT ((0)) NOT NULL,
    [ARLineRef]        CHAR (5)      DEFAULT (' ') NOT NULL,
    [BatNbr]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [BMICuryID]        CHAR (4)      DEFAULT (' ') NOT NULL,
    [BMIEffDate]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [BMIEstimatedCost] FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BMIExtCost]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BMIMultDiv]       CHAR (1)      DEFAULT (' ') NOT NULL,
    [BMIRate]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BMIRtTp]          CHAR (6)      DEFAULT (' ') NOT NULL,
    [BMITranAmt]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [BMIUnitPrice]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CmmnPct]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CnvFact]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [COGSAcct]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [COGSSub]          CHAR (24)     DEFAULT (' ') NOT NULL,
    [CostType]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [CpnyID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]        CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [DrCr]             CHAR (1)      DEFAULT (' ') NOT NULL,
    [EstimatedCost]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Excpt]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [ExtCost]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ExtRefNbr]        CHAR (15)     DEFAULT (' ') NOT NULL,
    [FiscYr]           CHAR (4)      DEFAULT (' ') NOT NULL,
    [FlatRateLineNbr]  SMALLINT      DEFAULT ((0)) NOT NULL,
    [ID]               CHAR (15)     DEFAULT (' ') NOT NULL,
    [InsuffQty]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [InvtAcct]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [InvtID]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [InvtMult]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [InvtSub]          CHAR (24)     DEFAULT (' ') NOT NULL,
    [IRProcessed]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [JrnlType]         CHAR (3)      DEFAULT (' ') NOT NULL,
    [KitID]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [KitStdQty]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [LayerType]        CHAR (1)      DEFAULT (' ') NOT NULL,
    [LineID]           INT           DEFAULT ((0)) NOT NULL,
    [LineNbr]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [LineRef]          CHAR (5)      DEFAULT (' ') NOT NULL,
    [LotSerCntr]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]        CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [NoteID]           INT           DEFAULT ((0)) NOT NULL,
    [OrigBatNbr]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [OrigJrnlType]     CHAR (3)      DEFAULT (' ') NOT NULL,
    [OrigLineRef]      CHAR (5)      DEFAULT (' ') NOT NULL,
    [OrigRefNbr]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [OvrhdAmt]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [OvrhdFlag]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [PC_Flag]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [PC_ID]            CHAR (20)     DEFAULT (' ') NOT NULL,
    [PC_Status]        CHAR (1)      DEFAULT (' ') NOT NULL,
    [PerEnt]           CHAR (6)      DEFAULT (' ') NOT NULL,
    [PerPost]          CHAR (6)      DEFAULT (' ') NOT NULL,
    [PoNbr]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [PostingOption]    SMALLINT      DEFAULT ((0)) NOT NULL,
    [ProjectID]        CHAR (16)     DEFAULT (' ') NOT NULL,
    [Qty]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyUnCosted]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [RcptDate]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [RcptNbr]          CHAR (15)     DEFAULT (' ') NOT NULL,
    [ReasonCd]         CHAR (6)      DEFAULT (' ') NOT NULL,
    [RecordID]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RefNbr]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [Retired]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [Rlsed]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [S4Future01]       CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]       CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]       INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]       INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [ServiceCallID]    CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipperCpnyID]    CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipperID]        CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipperLineRef]   CHAR (5)      DEFAULT (' ') NOT NULL,
    [ShortQty]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [SiteID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [SlsperID]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [SpecificCostID]   CHAR (25)     DEFAULT (' ') NOT NULL,
    [SrcDate]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SrcLineRef]       CHAR (5)      DEFAULT (' ') NOT NULL,
    [SrcNbr]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [SrcType]          CHAR (3)      DEFAULT (' ') NOT NULL,
    [StdTotalQty]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Sub]              CHAR (24)     DEFAULT (' ') NOT NULL,
    [SvcContractID]    CHAR (10)     DEFAULT (' ') NOT NULL,
    [SvcLineNbr]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [TaskID]           CHAR (32)     DEFAULT (' ') NOT NULL,
    [ToSiteID]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [ToWhseLoc]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [TranAmt]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TranDate]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [TranDesc]         CHAR (30)     DEFAULT (' ') NOT NULL,
    [TranType]         CHAR (2)      DEFAULT (' ') NOT NULL,
    [UnitCost]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [UnitDesc]         CHAR (6)      DEFAULT (' ') NOT NULL,
    [UnitMultDiv]      CHAR (1)      DEFAULT (' ') NOT NULL,
    [UnitPrice]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User1]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [UseTranCost]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [WhseLoc]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [INTran0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [SiteID] ASC, [CpnyID] ASC, [RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [INTran1]
    ON [dbo].[INTran]([InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC, [TranDate] ASC, [BatNbr] ASC, [RefNbr] ASC, [RecordID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran10]
    ON [dbo].[INTran]([ReasonCd] ASC, [InvtID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [INTran11]
    ON [dbo].[INTran]([BatNbr] ASC, [InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC, [RefNbr] ASC, [LineNbr] ASC, [RecordID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran12]
    ON [dbo].[INTran]([BatNbr] ASC, [RefNbr] ASC, [LineRef] ASC, [TranType] ASC, [ARLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [INTran13]
    ON [dbo].[INTran]([RecordID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran14]
    ON [dbo].[INTran]([CpnyID] ASC, [JrnlType] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran15]
    ON [dbo].[INTran]([TranType] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran16]
    ON [dbo].[INTran]([BatNbr] ASC, [RecordID] ASC, [CpnyID] ASC, [Rlsed] ASC, [TranType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran17]
    ON [dbo].[INTran]([JrnlType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran18]
    ON [dbo].[INTran]([BatNbr] ASC, [ID] ASC, [RefNbr] ASC, [ARLineID] ASC, [CpnyID] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran19]
    ON [dbo].[INTran]([BatNbr] ASC, [ShipperID] ASC, [ShipperLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran2]
    ON [dbo].[INTran]([InvtID] ASC, [SiteID] ASC, [PerPost] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran20]
    ON [dbo].[INTran]([InvtID] ASC, [SiteID] ASC, [Rlsed] ASC, [S4Future09] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran21]
    ON [dbo].[INTran]([Rlsed] ASC, [InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran22]
    ON [dbo].[INTran]([SiteID] ASC, [WhseLoc] ASC, [InvtID] ASC, [CnvFact] ASC, [Crtd_Prog] ASC, [InvtMult] ASC, [JrnlType] ASC, [Rlsed] ASC, [S4Future09] ASC, [TranType] ASC, [UnitMultDiv] ASC, [Qty] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran23]
    ON [dbo].[INTran]([BatNbr] ASC, [LineID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran24]
    ON [dbo].[INTran]([S4Future05] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran3]
    ON [dbo].[INTran]([RcptNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [INTran4]
    ON [dbo].[INTran]([BatNbr] ASC, [LineNbr] ASC, [LineID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran5]
    ON [dbo].[INTran]([BatNbr] ASC, [InvtID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran6]
    ON [dbo].[INTran]([BatNbr] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran7]
    ON [dbo].[INTran]([BatNbr] ASC, [InvtID] ASC, [Qty] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran8]
    ON [dbo].[INTran]([BatNbr] ASC, [KitID] ASC, [InvtID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INTran9]
    ON [dbo].[INTran]([BatNbr] ASC, [KitID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_intran_BatNbr_Refnbr]
    ON [dbo].[INTran]([BatNbr] ASC, [RefNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_intran_ExtRefnbr]
    ON [dbo].[INTran]([ExtRefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [sm_intran_Refnbr]
    ON [dbo].[INTran]([RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [intran_stran]
    ON [dbo].[INTran]([PC_Status] ASC, [PerPost] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_INTran_acctttyp_incl]
    ON [dbo].[INTran]([Acct] ASC, [TranType] ASC)
    INCLUDE([InvtID], [InvtMult], [Qty], [TaskID], [BatNbr]) WITH (FILLFACTOR = 100);

