CREATE TABLE [dbo].[LotSerT] (
    [BatNbr]        CHAR (10)     CONSTRAINT [DF_LotSerT_BatNbr] DEFAULT (' ') NOT NULL,
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_LotSerT_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_LotSerT_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_LotSerT_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_LotSerT_Crtd_User] DEFAULT (' ') NOT NULL,
    [CustID]        CHAR (15)     CONSTRAINT [DF_LotSerT_CustID] DEFAULT (' ') NOT NULL,
    [ExpDate]       SMALLDATETIME CONSTRAINT [DF_LotSerT_ExpDate] DEFAULT ('01/01/1900') NOT NULL,
    [INTranLineID]  INT           CONSTRAINT [DF_LotSerT_INTranLineID] DEFAULT ((0)) NOT NULL,
    [INTranLineRef] CHAR (5)      CONSTRAINT [DF_LotSerT_INTranLineRef] DEFAULT (' ') NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_LotSerT_InvtID] DEFAULT (' ') NOT NULL,
    [InvtMult]      SMALLINT      CONSTRAINT [DF_LotSerT_InvtMult] DEFAULT ((0)) NOT NULL,
    [KitID]         CHAR (30)     CONSTRAINT [DF_LotSerT_KitID] DEFAULT (' ') NOT NULL,
    [LineNbr]       SMALLINT      CONSTRAINT [DF_LotSerT_LineNbr] DEFAULT ((0)) NOT NULL,
    [LotSerNbr]     CHAR (25)     CONSTRAINT [DF_LotSerT_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LotSerRef]     CHAR (5)      CONSTRAINT [DF_LotSerT_LotSerRef] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_LotSerT_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_LotSerT_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_LotSerT_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr] CHAR (25)     CONSTRAINT [DF_LotSerT_MfgrLotSerNbr] DEFAULT (' ') NOT NULL,
    [NoQtyUpdate]   SMALLINT      CONSTRAINT [DF_LotSerT_NoQtyUpdate] DEFAULT ((0)) NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_LotSerT_NoteID] DEFAULT ((0)) NOT NULL,
    [ParInvtID]     CHAR (30)     CONSTRAINT [DF_LotSerT_ParInvtID] DEFAULT (' ') NOT NULL,
    [ParLotSerNbr]  CHAR (25)     CONSTRAINT [DF_LotSerT_ParLotSerNbr] DEFAULT (' ') NOT NULL,
    [Qty]           FLOAT (53)    CONSTRAINT [DF_LotSerT_Qty] DEFAULT ((0)) NOT NULL,
    [RcptNbr]       CHAR (10)     CONSTRAINT [DF_LotSerT_RcptNbr] DEFAULT (' ') NOT NULL,
    [RecordID]      INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RefNbr]        CHAR (15)     CONSTRAINT [DF_LotSerT_RefNbr] DEFAULT (' ') NOT NULL,
    [Retired]       SMALLINT      CONSTRAINT [DF_LotSerT_Retired] DEFAULT ((0)) NOT NULL,
    [Rlsed]         SMALLINT      CONSTRAINT [DF_LotSerT_Rlsed] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_LotSerT_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_LotSerT_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_LotSerT_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_LotSerT_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_LotSerT_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_LotSerT_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_LotSerT_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_LotSerT_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_LotSerT_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_LotSerT_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_LotSerT_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_LotSerT_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipContCode]  CHAR (20)     CONSTRAINT [DF_LotSerT_ShipContCode] DEFAULT (' ') NOT NULL,
    [ShipmentNbr]   SMALLINT      CONSTRAINT [DF_LotSerT_ShipmentNbr] DEFAULT ((0)) NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_LotSerT_SiteID] DEFAULT (' ') NOT NULL,
    [ToSiteID]      CHAR (10)     CONSTRAINT [DF_LotSerT_ToSiteID] DEFAULT (' ') NOT NULL,
    [ToWhseLoc]     CHAR (10)     CONSTRAINT [DF_LotSerT_ToWhseLoc] DEFAULT (' ') NOT NULL,
    [TranDate]      SMALLDATETIME CONSTRAINT [DF_LotSerT_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TranSrc]       CHAR (2)      CONSTRAINT [DF_LotSerT_TranSrc] DEFAULT (' ') NOT NULL,
    [TranTime]      SMALLDATETIME CONSTRAINT [DF_LotSerT_TranTime] DEFAULT ('01/01/1900') NOT NULL,
    [TranType]      CHAR (2)      CONSTRAINT [DF_LotSerT_TranType] DEFAULT (' ') NOT NULL,
    [UnitCost]      FLOAT (53)    CONSTRAINT [DF_LotSerT_UnitCost] DEFAULT ((0)) NOT NULL,
    [UnitPrice]     FLOAT (53)    CONSTRAINT [DF_LotSerT_UnitPrice] DEFAULT ((0)) NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_LotSerT_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_LotSerT_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_LotSerT_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_LotSerT_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_LotSerT_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_LotSerT_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_LotSerT_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_LotSerT_User8] DEFAULT ('01/01/1900') NOT NULL,
    [WarrantyDate]  SMALLDATETIME CONSTRAINT [DF_LotSerT_WarrantyDate] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]       CHAR (10)     CONSTRAINT [DF_LotSerT_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [LotSerT0] PRIMARY KEY CLUSTERED ([LotSerNbr] ASC, [RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [LotSerT1]
    ON [dbo].[LotSerT]([CpnyID] ASC, [BatNbr] ASC, [RefNbr] ASC, [INTranLineRef] ASC, [LotSerRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT10]
    ON [dbo].[LotSerT]([TranType] ASC, [INTranLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT11]
    ON [dbo].[LotSerT]([BatNbr] ASC, [CpnyID] ASC, [INTranLineRef] ASC, [SiteID] ASC, [TranType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT12]
    ON [dbo].[LotSerT]([InvtID] ASC, [SiteID] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT13]
    ON [dbo].[LotSerT]([Rlsed] ASC, [InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT2]
    ON [dbo].[LotSerT]([InvtID] ASC, [LotSerNbr] ASC, [CustID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT3]
    ON [dbo].[LotSerT]([InvtID] ASC, [LotSerNbr] ASC, [TranType] ASC, [TranDate] ASC, [TranTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT4]
    ON [dbo].[LotSerT]([InvtID] ASC, [LotSerNbr] ASC, [TranDate] ASC, [TranTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT5]
    ON [dbo].[LotSerT]([InvtID] ASC, [MfgrLotSerNbr] ASC, [TranType] ASC, [TranDate] ASC, [TranTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT6]
    ON [dbo].[LotSerT]([InvtID] ASC, [MfgrLotSerNbr] ASC, [TranDate] ASC, [TranTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT7]
    ON [dbo].[LotSerT]([TranSrc] ASC, [BatNbr] ASC, [INTranLineID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT8]
    ON [dbo].[LotSerT]([TranSrc] ASC, [RefNbr] ASC, [InvtID] ASC, [INTranLineID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerT9]
    ON [dbo].[LotSerT]([InvtID] ASC, [CustID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);

