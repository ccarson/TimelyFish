CREATE TABLE [dbo].[POReqDet] (
    [Acct]              CHAR (10)     CONSTRAINT [DF_POReqDet_Acct] DEFAULT (' ') NOT NULL,
    [AddlCostPct]       FLOAT (53)    CONSTRAINT [DF_POReqDet_AddlCostPct] DEFAULT ((0)) NOT NULL,
    [AlternateID]       CHAR (30)     CONSTRAINT [DF_POReqDet_AlternateID] DEFAULT (' ') NOT NULL,
    [AltIDType]         CHAR (1)      CONSTRAINT [DF_POReqDet_AltIDType] DEFAULT (' ') NOT NULL,
    [AppvLevObt]        CHAR (2)      CONSTRAINT [DF_POReqDet_AppvLevObt] DEFAULT (' ') NOT NULL,
    [AppvLevReq]        CHAR (2)      CONSTRAINT [DF_POReqDet_AppvLevReq] DEFAULT (' ') NOT NULL,
    [Budgeted]          CHAR (1)      CONSTRAINT [DF_POReqDet_Budgeted] DEFAULT (' ') NOT NULL,
    [Buyer]             CHAR (10)     CONSTRAINT [DF_POReqDet_Buyer] DEFAULT (' ') NOT NULL,
    [CatalogInfo]       CHAR (60)     CONSTRAINT [DF_POReqDet_CatalogInfo] DEFAULT (' ') NOT NULL,
    [CnvFact]           FLOAT (53)    CONSTRAINT [DF_POReqDet_CnvFact] DEFAULT ((0)) NOT NULL,
    [CommitAmtLeft]     FLOAT (53)    CONSTRAINT [DF_POReqDet_CommitAmtLeft] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME CONSTRAINT [DF_POReqDet_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]         CHAR (8)      CONSTRAINT [DF_POReqDet_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]         CHAR (10)     CONSTRAINT [DF_POReqDet_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryCommitAmtLeft] FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryCommitAmtLeft] DEFAULT ((0)) NOT NULL,
    [CuryExtCost]       FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryExtCost] DEFAULT ((0)) NOT NULL,
    [CuryID]            CHAR (4)      CONSTRAINT [DF_POReqDet_CuryID] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]       CHAR (1)      CONSTRAINT [DF_POReqDet_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryRate]          FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt00]      FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTaxAmt00] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt01]      FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTaxAmt01] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt02]      FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTaxAmt02] DEFAULT ((0)) NOT NULL,
    [CuryTaxAmt03]      FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTaxAmt03] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt00]     FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTxblAmt00] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt01]     FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTxblAmt01] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt02]     FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTxblAmt02] DEFAULT ((0)) NOT NULL,
    [CuryTxblAmt03]     FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryTxblAmt03] DEFAULT ((0)) NOT NULL,
    [CuryUnitCost]      FLOAT (53)    CONSTRAINT [DF_POReqDet_CuryUnitCost] DEFAULT ((0)) NOT NULL,
    [DeletedLine]       SMALLINT      CONSTRAINT [DF_POReqDet_DeletedLine] DEFAULT ((0)) NOT NULL,
    [Dept]              CHAR (10)     CONSTRAINT [DF_POReqDet_Dept] DEFAULT (' ') NOT NULL,
    [Descr]             CHAR (60)     CONSTRAINT [DF_POReqDet_Descr] DEFAULT (' ') NOT NULL,
    [ExtCost]           FLOAT (53)    CONSTRAINT [DF_POReqDet_ExtCost] DEFAULT ((0)) NOT NULL,
    [ExtWeight]         FLOAT (53)    CONSTRAINT [DF_POReqDet_ExtWeight] DEFAULT ((0)) NOT NULL,
    [InvtID]            CHAR (30)     CONSTRAINT [DF_POReqDet_InvtID] DEFAULT (' ') NOT NULL,
    [ItemLineID]        SMALLINT      CONSTRAINT [DF_POReqDet_ItemLineID] DEFAULT ((0)) NOT NULL,
    [ItemLineRef]       CHAR (5)      CONSTRAINT [DF_POReqDet_ItemLineRef] DEFAULT (' ') NOT NULL,
    [ItemReqNbr]        CHAR (10)     CONSTRAINT [DF_POReqDet_ItemReqNbr] DEFAULT (' ') NOT NULL,
    [KitUnexpID]        SMALLINT      CONSTRAINT [DF_POReqDet_KitUnexpID] DEFAULT ((0)) NOT NULL,
    [Labor_Class_Cd]    CHAR (4)      CONSTRAINT [DF_POReqDet_Labor_Class_Cd] DEFAULT (' ') NOT NULL,
    [LineID]            SMALLINT      CONSTRAINT [DF_POReqDet_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]           SMALLINT      CONSTRAINT [DF_POReqDet_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]           CHAR (5)      CONSTRAINT [DF_POReqDet_LineRef] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME CONSTRAINT [DF_POReqDet_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]         CHAR (8)      CONSTRAINT [DF_POReqDet_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]         CHAR (10)     CONSTRAINT [DF_POReqDet_LUpd_User] DEFAULT (' ') NOT NULL,
    [MaterialType]      CHAR (10)     CONSTRAINT [DF_POReqDet_MaterialType] DEFAULT (' ') NOT NULL,
    [NoteID]            INT           CONSTRAINT [DF_POReqDet_NoteID] DEFAULT ((0)) NOT NULL,
    [OrigPOSeq]         CHAR (1)      CONSTRAINT [DF_POReqDet_OrigPOSeq] DEFAULT (' ') NOT NULL,
    [PC_Flag]           CHAR (1)      CONSTRAINT [DF_POReqDet_PC_Flag] DEFAULT (' ') NOT NULL,
    [PC_ID]             CHAR (20)     CONSTRAINT [DF_POReqDet_PC_ID] DEFAULT (' ') NOT NULL,
    [PC_Status]         CHAR (1)      CONSTRAINT [DF_POReqDet_PC_Status] DEFAULT (' ') NOT NULL,
    [PolicyLevObt]      CHAR (2)      CONSTRAINT [DF_POReqDet_PolicyLevObt] DEFAULT (' ') NOT NULL,
    [PolicyLevReq]      CHAR (2)      CONSTRAINT [DF_POReqDet_PolicyLevReq] DEFAULT (' ') NOT NULL,
    [PrefVendorID]      CHAR (15)     CONSTRAINT [DF_POReqDet_PrefVendorID] DEFAULT (' ') NOT NULL,
    [Project]           CHAR (16)     CONSTRAINT [DF_POReqDet_Project] DEFAULT (' ') NOT NULL,
    [PromiseDate]       SMALLDATETIME CONSTRAINT [DF_POReqDet_PromiseDate] DEFAULT ('01/01/1900') NOT NULL,
    [PurchaseType]      CHAR (2)      CONSTRAINT [DF_POReqDet_PurchaseType] DEFAULT (' ') NOT NULL,
    [Qty]               FLOAT (53)    CONSTRAINT [DF_POReqDet_Qty] DEFAULT ((0)) NOT NULL,
    [RcptPctAct]        CHAR (1)      CONSTRAINT [DF_POReqDet_RcptPctAct] DEFAULT (' ') NOT NULL,
    [RcptPctMax]        FLOAT (53)    CONSTRAINT [DF_POReqDet_RcptPctMax] DEFAULT ((0)) NOT NULL,
    [RcptPctMin]        FLOAT (53)    CONSTRAINT [DF_POReqDet_RcptPctMin] DEFAULT ((0)) NOT NULL,
    [ReqCntr]           CHAR (2)      CONSTRAINT [DF_POReqDet_ReqCntr] DEFAULT (' ') NOT NULL,
    [ReqNbr]            CHAR (10)     CONSTRAINT [DF_POReqDet_ReqNbr] DEFAULT (' ') NOT NULL,
    [RequiredDate]      SMALLDATETIME CONSTRAINT [DF_POReqDet_RequiredDate] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future01]        CHAR (30)     CONSTRAINT [DF_POReqDet_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]        CHAR (30)     CONSTRAINT [DF_POReqDet_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]        FLOAT (53)    CONSTRAINT [DF_POReqDet_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]        FLOAT (53)    CONSTRAINT [DF_POReqDet_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]        FLOAT (53)    CONSTRAINT [DF_POReqDet_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]        FLOAT (53)    CONSTRAINT [DF_POReqDet_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]        SMALLDATETIME CONSTRAINT [DF_POReqDet_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]        SMALLDATETIME CONSTRAINT [DF_POReqDet_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]        INT           CONSTRAINT [DF_POReqDet_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]        INT           CONSTRAINT [DF_POReqDet_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]        CHAR (10)     CONSTRAINT [DF_POReqDet_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]        CHAR (10)     CONSTRAINT [DF_POReqDet_S4Future12] DEFAULT (' ') NOT NULL,
    [SeqNbr]            CHAR (4)      CONSTRAINT [DF_POReqDet_SeqNbr] DEFAULT (' ') NOT NULL,
    [ShipFrom]          CHAR (20)     CONSTRAINT [DF_POReqDet_ShipFrom] DEFAULT (' ') NOT NULL,
    [ShipVia]           CHAR (20)     CONSTRAINT [DF_POReqDet_ShipVia] DEFAULT (' ') NOT NULL,
    [SiteID]            CHAR (10)     CONSTRAINT [DF_POReqDet_SiteID] DEFAULT (' ') NOT NULL,
    [SourceOfRequest]   CHAR (3)      CONSTRAINT [DF_POReqDet_SourceOfRequest] DEFAULT (' ') NOT NULL,
    [Status]            CHAR (2)      CONSTRAINT [DF_POReqDet_Status] DEFAULT (' ') NOT NULL,
    [Sub]               CHAR (24)     CONSTRAINT [DF_POReqDet_Sub] DEFAULT (' ') NOT NULL,
    [Task]              CHAR (32)     CONSTRAINT [DF_POReqDet_Task] DEFAULT (' ') NOT NULL,
    [TaxAmt00]          FLOAT (53)    CONSTRAINT [DF_POReqDet_TaxAmt00] DEFAULT ((0)) NOT NULL,
    [TaxAmt01]          FLOAT (53)    CONSTRAINT [DF_POReqDet_TaxAmt01] DEFAULT ((0)) NOT NULL,
    [TaxAmt02]          FLOAT (53)    CONSTRAINT [DF_POReqDet_TaxAmt02] DEFAULT ((0)) NOT NULL,
    [TaxAmt03]          FLOAT (53)    CONSTRAINT [DF_POReqDet_TaxAmt03] DEFAULT ((0)) NOT NULL,
    [TaxCalced]         CHAR (1)      CONSTRAINT [DF_POReqDet_TaxCalced] DEFAULT (' ') NOT NULL,
    [TaxCat]            CHAR (10)     CONSTRAINT [DF_POReqDet_TaxCat] DEFAULT (' ') NOT NULL,
    [TaxID00]           CHAR (10)     CONSTRAINT [DF_POReqDet_TaxID00] DEFAULT (' ') NOT NULL,
    [TaxID01]           CHAR (10)     CONSTRAINT [DF_POReqDet_TaxID01] DEFAULT (' ') NOT NULL,
    [TaxID02]           CHAR (10)     CONSTRAINT [DF_POReqDet_TaxID02] DEFAULT (' ') NOT NULL,
    [TaxID03]           CHAR (10)     CONSTRAINT [DF_POReqDet_TaxID03] DEFAULT (' ') NOT NULL,
    [TaxIDDflt]         CHAR (10)     CONSTRAINT [DF_POReqDet_TaxIDDflt] DEFAULT (' ') NOT NULL,
    [Transfer]          CHAR (1)      CONSTRAINT [DF_POReqDet_Transfer] DEFAULT (' ') NOT NULL,
    [TxblAmt00]         FLOAT (53)    CONSTRAINT [DF_POReqDet_TxblAmt00] DEFAULT ((0)) NOT NULL,
    [TxblAmt01]         FLOAT (53)    CONSTRAINT [DF_POReqDet_TxblAmt01] DEFAULT ((0)) NOT NULL,
    [TxblAmt02]         FLOAT (53)    CONSTRAINT [DF_POReqDet_TxblAmt02] DEFAULT ((0)) NOT NULL,
    [TxblAmt03]         FLOAT (53)    CONSTRAINT [DF_POReqDet_TxblAmt03] DEFAULT ((0)) NOT NULL,
    [Unit]              CHAR (6)      CONSTRAINT [DF_POReqDet_Unit] DEFAULT (' ') NOT NULL,
    [UnitCost]          FLOAT (53)    CONSTRAINT [DF_POReqDet_UnitCost] DEFAULT ((0)) NOT NULL,
    [UnitMultDiv]       CHAR (1)      CONSTRAINT [DF_POReqDet_UnitMultDiv] DEFAULT (' ') NOT NULL,
    [UnitWeight]        FLOAT (53)    CONSTRAINT [DF_POReqDet_UnitWeight] DEFAULT ((0)) NOT NULL,
    [User1]             CHAR (30)     CONSTRAINT [DF_POReqDet_User1] DEFAULT (' ') NOT NULL,
    [User2]             CHAR (30)     CONSTRAINT [DF_POReqDet_User2] DEFAULT (' ') NOT NULL,
    [User3]             FLOAT (53)    CONSTRAINT [DF_POReqDet_User3] DEFAULT ((0)) NOT NULL,
    [User4]             FLOAT (53)    CONSTRAINT [DF_POReqDet_User4] DEFAULT ((0)) NOT NULL,
    [User5]             CHAR (10)     CONSTRAINT [DF_POReqDet_User5] DEFAULT (' ') NOT NULL,
    [User6]             CHAR (10)     CONSTRAINT [DF_POReqDet_User6] DEFAULT (' ') NOT NULL,
    [User7]             SMALLDATETIME CONSTRAINT [DF_POReqDet_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]             SMALLDATETIME CONSTRAINT [DF_POReqDet_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [POReqDet0] PRIMARY KEY CLUSTERED ([ReqNbr] ASC, [ReqCntr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [POReqDet1]
    ON [dbo].[POReqDet]([ReqCntr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqDet2]
    ON [dbo].[POReqDet]([SeqNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqDet3]
    ON [dbo].[POReqDet]([LineNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqDet4]
    ON [dbo].[POReqDet]([InvtID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqDet5]
    ON [dbo].[POReqDet]([Status] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqDet6]
    ON [dbo].[POReqDet]([LineRef] ASC) WITH (FILLFACTOR = 100);

