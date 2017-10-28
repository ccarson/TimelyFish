CREATE TABLE [dbo].[BOMTran] (
    [AssyQty]        FLOAT (53)    CONSTRAINT [DF_BOMTran_AssyQty] DEFAULT ((0)) NOT NULL,
    [BatNbr]         CHAR (10)     CONSTRAINT [DF_BOMTran_BatNbr] DEFAULT (' ') NOT NULL,
    [BOMLevel]       SMALLINT      CONSTRAINT [DF_BOMTran_BOMLevel] DEFAULT ((0)) NOT NULL,
    [BOMLineNbr]     SMALLINT      CONSTRAINT [DF_BOMTran_BOMLineNbr] DEFAULT ((0)) NOT NULL,
    [BOMQty]         FLOAT (53)    CONSTRAINT [DF_BOMTran_BOMQty] DEFAULT ((0)) NOT NULL,
    [BOMSiteID]      CHAR (10)     CONSTRAINT [DF_BOMTran_BOMSiteID] DEFAULT (' ') NOT NULL,
    [CmpnentID]      CHAR (30)     CONSTRAINT [DF_BOMTran_CmpnentID] DEFAULT (' ') NOT NULL,
    [CmpnentQty]     FLOAT (53)    CONSTRAINT [DF_BOMTran_CmpnentQty] DEFAULT ((0)) NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_BOMTran_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_BOMTran_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_BOMTran_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_BOMTran_Crtd_User] DEFAULT (' ') NOT NULL,
    [DeleteFlag]     SMALLINT      CONSTRAINT [DF_BOMTran_DeleteFlag] DEFAULT ((0)) NOT NULL,
    [DirAssyAmt]     FLOAT (53)    CONSTRAINT [DF_BOMTran_DirAssyAmt] DEFAULT ((0)) NOT NULL,
    [DirCmpnentAmt]  FLOAT (53)    CONSTRAINT [DF_BOMTran_DirCmpnentAmt] DEFAULT ((0)) NOT NULL,
    [DirEffVarAmt]   FLOAT (53)    CONSTRAINT [DF_BOMTran_DirEffVarAmt] DEFAULT ((0)) NOT NULL,
    [DirRateVarAmt]  FLOAT (53)    CONSTRAINT [DF_BOMTran_DirRateVarAmt] DEFAULT ((0)) NOT NULL,
    [KitID]          CHAR (30)     CONSTRAINT [DF_BOMTran_KitID] DEFAULT (' ') NOT NULL,
    [KitSiteID]      CHAR (10)     CONSTRAINT [DF_BOMTran_KitSiteID] DEFAULT (' ') NOT NULL,
    [KitStatus]      CHAR (1)      CONSTRAINT [DF_BOMTran_KitStatus] DEFAULT (' ') NOT NULL,
    [LineID]         INT           CONSTRAINT [DF_BOMTran_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]        SMALLINT      CONSTRAINT [DF_BOMTran_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]        CHAR (5)      CONSTRAINT [DF_BOMTran_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerCntr]     SMALLINT      CONSTRAINT [DF_BOMTran_LotSerCntr] DEFAULT ((0)) NOT NULL,
    [LotSerNbr]      CHAR (25)     CONSTRAINT [DF_BOMTran_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_BOMTran_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_BOMTran_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_BOMTran_LUpd_User] DEFAULT (' ') NOT NULL,
    [MCActivated]    SMALLINT      CONSTRAINT [DF_BOMTran_MCActivated] DEFAULT ((0)) NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_BOMTran_NoteID] DEFAULT ((0)) NOT NULL,
    [OvhAssyAmt]     FLOAT (53)    CONSTRAINT [DF_BOMTran_OvhAssyAmt] DEFAULT ((0)) NOT NULL,
    [OvhCmpnentAmt]  FLOAT (53)    CONSTRAINT [DF_BOMTran_OvhCmpnentAmt] DEFAULT ((0)) NOT NULL,
    [OvhEffVarAmt]   FLOAT (53)    CONSTRAINT [DF_BOMTran_OvhEffVarAmt] DEFAULT ((0)) NOT NULL,
    [OvhRateVarAmt]  FLOAT (53)    CONSTRAINT [DF_BOMTran_OvhRateVarAmt] DEFAULT ((0)) NOT NULL,
    [RefNbr]         CHAR (10)     CONSTRAINT [DF_BOMTran_RefNbr] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_BOMTran_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_BOMTran_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_BOMTran_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_BOMTran_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_BOMTran_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_BOMTran_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_BOMTran_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_BOMTran_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_BOMTran_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_BOMTran_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_BOMTran_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_BOMTran_S4Future12] DEFAULT (' ') NOT NULL,
    [Sequence]       CHAR (5)      CONSTRAINT [DF_BOMTran_Sequence] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_BOMTran_SiteID] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_BOMTran_SpecificCostID] DEFAULT (' ') NOT NULL,
    [Status]         CHAR (1)      CONSTRAINT [DF_BOMTran_Status] DEFAULT (' ') NOT NULL,
    [StdQty]         FLOAT (53)    CONSTRAINT [DF_BOMTran_StdQty] DEFAULT ((0)) NOT NULL,
    [StockUsage]     CHAR (1)      CONSTRAINT [DF_BOMTran_StockUsage] DEFAULT (' ') NOT NULL,
    [SubKitStatus]   CHAR (1)      CONSTRAINT [DF_BOMTran_SubKitStatus] DEFAULT (' ') NOT NULL,
    [TotAssyAmt]     FLOAT (53)    CONSTRAINT [DF_BOMTran_TotAssyAmt] DEFAULT ((0)) NOT NULL,
    [TotCmpnentAmt]  FLOAT (53)    CONSTRAINT [DF_BOMTran_TotCmpnentAmt] DEFAULT ((0)) NOT NULL,
    [TotEffVarAmt]   FLOAT (53)    CONSTRAINT [DF_BOMTran_TotEffVarAmt] DEFAULT ((0)) NOT NULL,
    [TotRateVarAmt]  FLOAT (53)    CONSTRAINT [DF_BOMTran_TotRateVarAmt] DEFAULT ((0)) NOT NULL,
    [TotVarAmt]      FLOAT (53)    CONSTRAINT [DF_BOMTran_TotVarAmt] DEFAULT ((0)) NOT NULL,
    [TranAmt]        FLOAT (53)    CONSTRAINT [DF_BOMTran_TranAmt] DEFAULT ((0)) NOT NULL,
    [TranDate]       SMALLDATETIME CONSTRAINT [DF_BOMTran_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TranType]       CHAR (2)      CONSTRAINT [DF_BOMTran_TranType] DEFAULT (' ') NOT NULL,
    [UnitPrice]      FLOAT (53)    CONSTRAINT [DF_BOMTran_UnitPrice] DEFAULT ((0)) NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_BOMTran_User1] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_BOMTran_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_BOMTran_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_BOMTran_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_BOMTran_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_BOMTran_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_BOMTran_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_BOMTran_User8] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_BOMTran_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [BOMTran0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [RefNbr] ASC, [KitID] ASC, [KitSiteID] ASC, [BOMLineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [BOMTran1]
    ON [dbo].[BOMTran]([CmpnentID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [BOMTran2]
    ON [dbo].[BOMTran]([RefNbr] ASC, [KitID] ASC, [CmpnentID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [BOMTran3]
    ON [dbo].[BOMTran]([RefNbr] ASC, [KitID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [BOMTran4]
    ON [dbo].[BOMTran]([RefNbr] ASC, [BOMLineNbr] ASC) WITH (FILLFACTOR = 90);

