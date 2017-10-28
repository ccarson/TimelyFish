CREATE TABLE [dbo].[SOShipLot] (
    [BoxRef]         CHAR (5)      CONSTRAINT [DF_SOShipLot_BoxRef] DEFAULT (' ') NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_SOShipLot_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOShipLot_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_SOShipLot_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_SOShipLot_Crtd_User] DEFAULT (' ') NOT NULL,
    [DropShip]       SMALLINT      CONSTRAINT [DF_SOShipLot_DropShip] DEFAULT ((0)) NOT NULL,
    [InvtId]         CHAR (30)     CONSTRAINT [DF_SOShipLot_InvtId] DEFAULT (' ') NOT NULL,
    [LineRef]        CHAR (5)      CONSTRAINT [DF_SOShipLot_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerNbr]      CHAR (25)     CONSTRAINT [DF_SOShipLot_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LotSerRef]      CHAR (5)      CONSTRAINT [DF_SOShipLot_LotSerRef] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOShipLot_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_SOShipLot_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_SOShipLot_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr]  CHAR (25)     CONSTRAINT [DF_SOShipLot_MfgrLotSerNbr] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_SOShipLot_NoteID] DEFAULT ((0)) NOT NULL,
    [OrdLineRef]     CHAR (5)      CONSTRAINT [DF_SOShipLot_OrdLineRef] DEFAULT (' ') NOT NULL,
    [OrdLotSerRef]   CHAR (5)      CONSTRAINT [DF_SOShipLot_OrdLotSerRef] DEFAULT (' ') NOT NULL,
    [OrdNbr]         CHAR (15)     CONSTRAINT [DF_SOShipLot_OrdNbr] DEFAULT (' ') NOT NULL,
    [OrdSchedRef]    CHAR (5)      CONSTRAINT [DF_SOShipLot_OrdSchedRef] DEFAULT (' ') NOT NULL,
    [QtyPick]        FLOAT (53)    CONSTRAINT [DF_SOShipLot_QtyPick] DEFAULT ((0)) NOT NULL,
    [QtyPickStock]   FLOAT (53)    CONSTRAINT [DF_SOShipLot_QtyPickStock] DEFAULT ((0)) NOT NULL,
    [QtyShip]        FLOAT (53)    CONSTRAINT [DF_SOShipLot_QtyShip] DEFAULT ((0)) NOT NULL,
    [RMADisposition] CHAR (3)      CONSTRAINT [DF_SOShipLot_RMADisposition] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_SOShipLot_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_SOShipLot_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_SOShipLot_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_SOShipLot_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_SOShipLot_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_SOShipLot_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_SOShipLot_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_SOShipLot_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_SOShipLot_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_SOShipLot_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_SOShipLot_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_SOShipLot_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]      CHAR (15)     CONSTRAINT [DF_SOShipLot_ShipperID] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_SOShipLot_SpecificCostID] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_SOShipLot_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_SOShipLot_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_SOShipLot_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_SOShipLot_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_SOShipLot_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_SOShipLot_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_SOShipLot_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_SOShipLot_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_SOShipLot_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_SOShipLot_User9] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_SOShipLot_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [SOShipLot0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [ShipperID] ASC, [LineRef] ASC, [LotSerRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SOShipLot1]
    ON [dbo].[SOShipLot]([S4Future11] ASC, [S4Future03] ASC, [QtyShip] ASC, [WhseLoc] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipLot2]
    ON [dbo].[SOShipLot]([WhseLoc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOShipLot3]
    ON [dbo].[SOShipLot]([InvtId] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);

