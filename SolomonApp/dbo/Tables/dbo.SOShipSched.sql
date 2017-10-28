CREATE TABLE [dbo].[SOShipSched] (
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_SOShipSched_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOShipSched_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_SOShipSched_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_SOShipSched_Crtd_User] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOShipSched_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_SOShipSched_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_SOShipSched_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_SOShipSched_NoteID] DEFAULT ((0)) NOT NULL,
    [OrdLineRef]     CHAR (5)      CONSTRAINT [DF_SOShipSched_OrdLineRef] DEFAULT (' ') NOT NULL,
    [OrdNbr]         CHAR (15)     CONSTRAINT [DF_SOShipSched_OrdNbr] DEFAULT (' ') NOT NULL,
    [OrdSchedRef]    CHAR (5)      CONSTRAINT [DF_SOShipSched_OrdSchedRef] DEFAULT (' ') NOT NULL,
    [QtyPick]        FLOAT (53)    CONSTRAINT [DF_SOShipSched_QtyPick] DEFAULT ((0)) NOT NULL,
    [ReqDate]        SMALLDATETIME CONSTRAINT [DF_SOShipSched_ReqDate] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_SOShipSched_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_SOShipSched_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_SOShipSched_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_SOShipSched_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_SOShipSched_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_SOShipSched_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_SOShipSched_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_SOShipSched_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_SOShipSched_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_SOShipSched_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_SOShipSched_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_SOShipSched_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]      CHAR (15)     CONSTRAINT [DF_SOShipSched_ShipperID] DEFAULT (' ') NOT NULL,
    [ShipperLineRef] CHAR (5)      CONSTRAINT [DF_SOShipSched_ShipperLineRef] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_SOShipSched_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_SOShipSched_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_SOShipSched_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_SOShipSched_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_SOShipSched_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_SOShipSched_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_SOShipSched_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_SOShipSched_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_SOShipSched_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_SOShipSched_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [SOShipSched0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [ShipperID] ASC, [ShipperLineRef] ASC, [OrdNbr] ASC, [OrdLineRef] ASC, [OrdSchedRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SOShipSched1]
    ON [dbo].[SOShipSched]([CpnyID] ASC, [ShipperID] ASC, [ShipperLineRef] ASC, [OrdNbr] ASC, [OrdLineRef] ASC, [ReqDate] ASC, [OrdSchedRef] ASC) WITH (FILLFACTOR = 90);

