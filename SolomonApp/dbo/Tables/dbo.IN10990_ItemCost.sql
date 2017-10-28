CREATE TABLE [dbo].[IN10990_ItemCost] (
    [BMITotCost]     FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_BMITotCost] DEFAULT ((0)) NOT NULL,
    [Changed]        BIT           NOT NULL,
    [CostIdentity]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_IN10990_ItemCost_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_Crtd_User] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_IN10990_ItemCost_InvtID] DEFAULT (' ') NOT NULL,
    [LayerType]      CHAR (2)      CONSTRAINT [DF_IN10990_ItemCost_LayerType] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_IN10990_ItemCost_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_LUpd_User] DEFAULT (' ') NOT NULL,
    [MstStamp]       BINARY (8)    NOT NULL,
    [Qty]            FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_Qty] DEFAULT ((0)) NOT NULL,
    [RcptDate]       SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_RcptDate] DEFAULT ('01/01/1900') NOT NULL,
    [RcptNbr]        CHAR (15)     CONSTRAINT [DF_IN10990_ItemCost_RcptNbr] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_IN10990_ItemCost_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_IN10990_ItemCost_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_IN10990_ItemCost_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_IN10990_ItemCost_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_SiteID] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_IN10990_ItemCost_SpecificCostID] DEFAULT (' ') NOT NULL,
    [TotCost]        FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_TotCost] DEFAULT ((0)) NOT NULL,
    [UnitCost]       FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_UnitCost] DEFAULT ((0)) NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_IN10990_ItemCost_User1] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_IN10990_ItemCost_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_IN10990_ItemCost_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_IN10990_ItemCost_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_IN10990_ItemCost_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [IN10990_ItemCost0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [SiteID] ASC, [LayerType] ASC, [SpecificCostID] ASC, [RcptNbr] ASC, [RcptDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IN10990_ItemCost1]
    ON [dbo].[IN10990_ItemCost]([InvtID] ASC, [SiteID] ASC, [LayerType] ASC, [SpecificCostID] ASC, [RcptDate] ASC, [RcptNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_ItemCost2]
    ON [dbo].[IN10990_ItemCost]([InvtID] ASC, [SiteID] ASC, [LayerType] ASC, [RcptDate] ASC, [RcptNbr] ASC) WITH (FILLFACTOR = 90);

