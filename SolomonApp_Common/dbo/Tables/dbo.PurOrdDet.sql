CREATE TABLE [dbo].[PurOrdDet] (
    [AddlCostPct]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [AllocCntr]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [AlternateID]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [AltIDType]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [BlktLineID]           INT           DEFAULT ((0)) NOT NULL,
    [BlktLineRef]          CHAR (5)      DEFAULT (' ') NOT NULL,
    [Buyer]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [CnvFact]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CostReceived]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CostReturned]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CostVouched]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CpnyID]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]            CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [CuryCostReceived]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryCostReturned]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryCostVouched]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryExtCost]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryID]               CHAR (4)      DEFAULT (' ') NOT NULL,
    [CuryMultDiv]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [CuryRate]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt00]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt01]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt02]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt03]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt00]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt01]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt02]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt03]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CuryUnitCost]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ExtCost]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ExtWeight]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [FlatRateLineNbr]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [InclForecastUsageClc] SMALLINT      DEFAULT ((0)) NOT NULL,
    [InvtID]               CHAR (30)     DEFAULT (' ') NOT NULL,
    [IRIncLeadTime]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [KitUnExpld]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [Labor_Class_Cd]       CHAR (4)      DEFAULT (' ') NOT NULL,
    [LineID]               INT           DEFAULT ((0)) NOT NULL,
    [LineNbr]              SMALLINT      DEFAULT ((0)) NOT NULL,
    [LineRef]              CHAR (5)      DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]            CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [NoteID]               INT           DEFAULT ((0)) NOT NULL,
    [OpenLine]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [OrigPOLine]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [PC_Flag]              CHAR (1)      DEFAULT (' ') NOT NULL,
    [PC_ID]                CHAR (20)     DEFAULT (' ') NOT NULL,
    [PC_Status]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [PONbr]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [POType]               CHAR (2)      DEFAULT (' ') NOT NULL,
    [ProjectID]            CHAR (16)     DEFAULT (' ') NOT NULL,
    [PromDate]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [PurAcct]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [PurchaseType]         CHAR (2)      DEFAULT (' ') NOT NULL,
    [PurchUnit]            CHAR (6)      DEFAULT (' ') NOT NULL,
    [PurSub]               CHAR (24)     DEFAULT (' ') NOT NULL,
    [QtyOrd]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyRcvd]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyReturned]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyVouched]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [RcptPctAct]           CHAR (1)      DEFAULT (' ') NOT NULL,
    [RcptPctMax]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [RcptPctMin]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [RcptStage]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [ReasonCd]             CHAR (6)      DEFAULT (' ') NOT NULL,
    [RefNbr]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [ReqdDate]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [ReqNbr]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future01]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]           INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]           INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [ServiceCallID]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShelfLife]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [ShipAddr1]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [ShipAddr2]            CHAR (60)     DEFAULT (' ') NOT NULL,
    [ShipAddrID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipCity]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [ShipCountry]          CHAR (3)      DEFAULT (' ') NOT NULL,
    [ShipName]             CHAR (60)     DEFAULT (' ') NOT NULL,
    [ShipState]            CHAR (3)      DEFAULT (' ') NOT NULL,
    [ShipViaID]            CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipZip]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [SiteID]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [SOLineRef]            CHAR (5)      DEFAULT (' ') NOT NULL,
    [SOOrdNbr]             CHAR (15)     DEFAULT (' ') NOT NULL,
    [SOSchedRef]           CHAR (5)      DEFAULT (' ') NOT NULL,
    [StepNbr]              SMALLINT      DEFAULT ((0)) NOT NULL,
    [SvcContractID]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [SvcLineNbr]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [TaskID]               CHAR (32)     DEFAULT (' ') NOT NULL,
    [TaxAmt00]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TaxAmt01]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TaxAmt02]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TaxAmt03]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TaxCalced]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [TaxCat]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID00]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID01]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID02]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID03]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxIdDflt]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [TranDesc]             CHAR (60)     DEFAULT (' ') NOT NULL,
    [TxblAmt00]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TxblAmt01]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TxblAmt02]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [TxblAmt03]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [UnitCost]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [UnitMultDiv]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [UnitWeight]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User1]                CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]                CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]                FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]                FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]                SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]                SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [VouchStage]           CHAR (1)      DEFAULT (' ') NOT NULL,
    [WIP_COGS_Acct]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [WIP_COGS_Sub]         CHAR (24)     DEFAULT (' ') NOT NULL,
    [WOBOMSeq]             SMALLINT      DEFAULT ((0)) NOT NULL,
    [WOCostType]           CHAR (2)      DEFAULT (' ') NOT NULL,
    [WONbr]                CHAR (10)     DEFAULT (' ') NOT NULL,
    [WOStepNbr]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [PurOrdDet0] PRIMARY KEY CLUSTERED ([PONbr] ASC, [LineRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PurOrdDet1]
    ON [dbo].[PurOrdDet]([InvtID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [PurOrdDet2]
    ON [dbo].[PurOrdDet]([ReasonCd] ASC, [InvtID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [PurOrdDet3]
    ON [dbo].[PurOrdDet]([PONbr] ASC, [LineRef] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [PurOrdDet4]
    ON [dbo].[PurOrdDet]([InvtID] ASC, [SiteID] ASC, [OpenLine] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [PurOrdDet5]
    ON [dbo].[PurOrdDet]([ProjectID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [purorddet_stran]
    ON [dbo].[PurOrdDet]([PC_Status] ASC) WITH (FILLFACTOR = 100);

