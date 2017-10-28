CREATE TABLE [dbo].[SOLot] (
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_SOLot_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOLot_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_SOLot_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_SOLot_Crtd_User] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_SOLot_InvtID] DEFAULT (' ') NOT NULL,
    [LineRef]        CHAR (5)      CONSTRAINT [DF_SOLot_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerNbr]      CHAR (25)     CONSTRAINT [DF_SOLot_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LotSerRef]      CHAR (5)      CONSTRAINT [DF_SOLot_LotSerRef] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOLot_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_SOLot_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_SOLot_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr]  CHAR (25)     CONSTRAINT [DF_SOLot_MfgrLotSerNbr] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_SOLot_NoteID] DEFAULT ((0)) NOT NULL,
    [OrdNbr]         CHAR (15)     CONSTRAINT [DF_SOLot_OrdNbr] DEFAULT (' ') NOT NULL,
    [QtyShip]        FLOAT (53)    CONSTRAINT [DF_SOLot_QtyShip] DEFAULT ((0)) NOT NULL,
    [QtyShipStock]   FLOAT (53)    CONSTRAINT [DF_SOLot_QtyShipStock] DEFAULT ((0)) NOT NULL,
    [RMADisposition] CHAR (3)      CONSTRAINT [DF_SOLot_RMADisposition] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_SOLot_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_SOLot_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_SOLot_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_SOLot_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_SOLot_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_SOLot_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_SOLot_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_SOLot_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_SOLot_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_SOLot_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_SOLot_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_SOLot_S4Future12] DEFAULT (' ') NOT NULL,
    [SchedRef]       CHAR (5)      CONSTRAINT [DF_SOLot_SchedRef] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_SOLot_SpecificCostID] DEFAULT (' ') NOT NULL,
    [Status]         CHAR (1)      CONSTRAINT [DF_SOLot_Status] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_SOLot_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_SOLot_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_SOLot_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_SOLot_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_SOLot_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_SOLot_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_SOLot_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_SOLot_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_SOLot_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_SOLot_User9] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_SOLot_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [SOLot0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [OrdNbr] ASC, [LineRef] ASC, [SchedRef] ASC, [LotSerRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SOLot1]
    ON [dbo].[SOLot]([WhseLoc] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOLot2]
    ON [dbo].[SOLot]([InvtID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);

