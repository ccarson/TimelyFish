CREATE TABLE [dbo].[IN10990_LotSerMst] (
    [Changed]       BIT           NOT NULL,
    [Cost]          FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_Cost] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_IN10990_LotSerMst_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_Crtd_User] DEFAULT (' ') NOT NULL,
    [ExpDate]       SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_ExpDate] DEFAULT ('01/01/1900') NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_IN10990_LotSerMst_InvtID] DEFAULT (' ') NOT NULL,
    [LotSerNbr]     CHAR (25)     CONSTRAINT [DF_IN10990_LotSerMst_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_IN10990_LotSerMst_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr] CHAR (25)     CONSTRAINT [DF_IN10990_LotSerMst_MfgrLotSerNbr] DEFAULT (' ') NOT NULL,
    [MstStamp]      BINARY (8)    NOT NULL,
    [OrigQty]       FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_OrigQty] DEFAULT ((0)) NOT NULL,
    [QtyOnHand]     FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_QtyOnHand] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_IN10990_LotSerMst_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_IN10990_LotSerMst_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_IN10990_LotSerMst_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_IN10990_LotSerMst_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipContCode]  CHAR (20)     CONSTRAINT [DF_IN10990_LotSerMst_ShipContCode] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_SiteID] DEFAULT (' ') NOT NULL,
    [Source]        CHAR (2)      CONSTRAINT [DF_IN10990_LotSerMst_Source] DEFAULT (' ') NOT NULL,
    [SrcOrdNbr]     CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_SrcOrdNbr] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_IN10990_LotSerMst_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_IN10990_LotSerMst_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_IN10990_LotSerMst_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_User8] DEFAULT ('01/01/1900') NOT NULL,
    [WarrantyDate]  SMALLDATETIME CONSTRAINT [DF_IN10990_LotSerMst_WarrantyDate] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]       CHAR (10)     CONSTRAINT [DF_IN10990_LotSerMst_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [IN10990_LotSerMst0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [LotSerNbr] ASC, [SiteID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IN10990_LotSerMst1]
    ON [dbo].[IN10990_LotSerMst]([InvtID] ASC, [SiteID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_LotSerMst2]
    ON [dbo].[IN10990_LotSerMst]([InvtID] ASC, [MfgrLotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_LotSerMst3]
    ON [dbo].[IN10990_LotSerMst]([InvtID] ASC, [SiteID] ASC, [ExpDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_LotSerMst4]
    ON [dbo].[IN10990_LotSerMst]([ShipContCode] ASC, [InvtID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);

