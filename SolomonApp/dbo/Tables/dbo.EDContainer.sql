CREATE TABLE [dbo].[EDContainer] (
    [AHCharge]           FLOAT (53)    CONSTRAINT [DF_EDContainer_AHCharge] DEFAULT ((0)) NOT NULL,
    [AirBillNbr]         CHAR (30)     CONSTRAINT [DF_EDContainer_AirBillNbr] DEFAULT (' ') NOT NULL,
    [BillFreightAmt]     FLOAT (53)    CONSTRAINT [DF_EDContainer_BillFreightAmt] DEFAULT ((0)) NOT NULL,
    [BolNbr]             CHAR (20)     CONSTRAINT [DF_EDContainer_BolNbr] DEFAULT (' ') NOT NULL,
    [CODCharge]          FLOAT (53)    CONSTRAINT [DF_EDContainer_CODCharge] DEFAULT ((0)) NOT NULL,
    [ContainerID]        CHAR (10)     CONSTRAINT [DF_EDContainer_ContainerID] DEFAULT (' ') NOT NULL,
    [CpnyID]             CHAR (10)     CONSTRAINT [DF_EDContainer_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_Datetime]      SMALLDATETIME CONSTRAINT [DF_EDContainer_Crtd_Datetime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]          CHAR (8)      CONSTRAINT [DF_EDContainer_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]          CHAR (10)     CONSTRAINT [DF_EDContainer_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryAHCharge]       FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryAHCharge] DEFAULT ((0)) NOT NULL,
    [CuryBillFreightAmt] FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryBillFreightAmt] DEFAULT ((0)) NOT NULL,
    [CuryCODCharge]      FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryCODCharge] DEFAULT ((0)) NOT NULL,
    [CuryEffDate]        SMALLDATETIME CONSTRAINT [DF_EDContainer_CuryEffDate] DEFAULT ('01/01/1900') NOT NULL,
    [CuryFreightAmt]     FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryFreightAmt] DEFAULT ((0)) NOT NULL,
    [CuryHazCharge]      FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryHazCharge] DEFAULT ((0)) NOT NULL,
    [CuryID]             CHAR (4)      CONSTRAINT [DF_EDContainer_CuryID] DEFAULT (' ') NOT NULL,
    [CuryInsurCharge]    FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryInsurCharge] DEFAULT ((0)) NOT NULL,
    [CuryMiscCharge]     FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryMiscCharge] DEFAULT ((0)) NOT NULL,
    [CuryMultDiv]        CHAR (1)      CONSTRAINT [DF_EDContainer_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryOverSizeCharge] FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryOverSizeCharge] DEFAULT ((0)) NOT NULL,
    [CuryPickupCharge]   FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryPickupCharge] DEFAULT ((0)) NOT NULL,
    [CuryRate]           FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryRateType]       CHAR (6)      CONSTRAINT [DF_EDContainer_CuryRateType] DEFAULT (' ') NOT NULL,
    [CuryShpCharge]      FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryShpCharge] DEFAULT ((0)) NOT NULL,
    [CurySurCharge]      FLOAT (53)    CONSTRAINT [DF_EDContainer_CurySurCharge] DEFAULT ((0)) NOT NULL,
    [CuryTotBillCharge]  FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryTotBillCharge] DEFAULT ((0)) NOT NULL,
    [CuryTotShipCharge]  FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryTotShipCharge] DEFAULT ((0)) NOT NULL,
    [CuryTrackCharge]    FLOAT (53)    CONSTRAINT [DF_EDContainer_CuryTrackCharge] DEFAULT ((0)) NOT NULL,
    [FreightAmt]         FLOAT (53)    CONSTRAINT [DF_EDContainer_FreightAmt] DEFAULT ((0)) NOT NULL,
    [HazCharge]          FLOAT (53)    CONSTRAINT [DF_EDContainer_HazCharge] DEFAULT ((0)) NOT NULL,
    [Height]             FLOAT (53)    CONSTRAINT [DF_EDContainer_Height] DEFAULT ((0)) NOT NULL,
    [HeightUOM]          CHAR (6)      CONSTRAINT [DF_EDContainer_HeightUOM] DEFAULT (' ') NOT NULL,
    [InsurCharge]        FLOAT (53)    CONSTRAINT [DF_EDContainer_InsurCharge] DEFAULT ((0)) NOT NULL,
    [LabelLastPrinted]   SMALLDATETIME CONSTRAINT [DF_EDContainer_LabelLastPrinted] DEFAULT ('01/01/1900') NOT NULL,
    [LabelPrinted]       SMALLINT      CONSTRAINT [DF_EDContainer_LabelPrinted] DEFAULT ((0)) NOT NULL,
    [Len]                FLOAT (53)    CONSTRAINT [DF_EDContainer_Len] DEFAULT ((0)) NOT NULL,
    [LenUOM]             CHAR (6)      CONSTRAINT [DF_EDContainer_LenUOM] DEFAULT (' ') NOT NULL,
    [Lupd_Datetime]      SMALLDATETIME CONSTRAINT [DF_EDContainer_Lupd_Datetime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]          CHAR (8)      CONSTRAINT [DF_EDContainer_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]          CHAR (10)     CONSTRAINT [DF_EDContainer_Lupd_User] DEFAULT (' ') NOT NULL,
    [MiscCharge]         FLOAT (53)    CONSTRAINT [DF_EDContainer_MiscCharge] DEFAULT ((0)) NOT NULL,
    [NoteID]             INT           CONSTRAINT [DF_EDContainer_NoteID] DEFAULT ((0)) NOT NULL,
    [OverSizeCharge]     FLOAT (53)    CONSTRAINT [DF_EDContainer_OverSizeCharge] DEFAULT ((0)) NOT NULL,
    [PackMethod]         CHAR (2)      CONSTRAINT [DF_EDContainer_PackMethod] DEFAULT (' ') NOT NULL,
    [PickupCharge]       FLOAT (53)    CONSTRAINT [DF_EDContainer_PickupCharge] DEFAULT ((0)) NOT NULL,
    [S4Future01]         CHAR (30)     CONSTRAINT [DF_EDContainer_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]         CHAR (30)     CONSTRAINT [DF_EDContainer_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]         FLOAT (53)    CONSTRAINT [DF_EDContainer_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]         FLOAT (53)    CONSTRAINT [DF_EDContainer_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]         FLOAT (53)    CONSTRAINT [DF_EDContainer_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]         FLOAT (53)    CONSTRAINT [DF_EDContainer_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]         SMALLDATETIME CONSTRAINT [DF_EDContainer_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]         SMALLDATETIME CONSTRAINT [DF_EDContainer_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]         INT           CONSTRAINT [DF_EDContainer_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]         INT           CONSTRAINT [DF_EDContainer_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]         CHAR (10)     CONSTRAINT [DF_EDContainer_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]         CHAR (10)     CONSTRAINT [DF_EDContainer_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]          CHAR (15)     CONSTRAINT [DF_EDContainer_ShipperID] DEFAULT (' ') NOT NULL,
    [ShipStatus]         CHAR (1)      CONSTRAINT [DF_EDContainer_ShipStatus] DEFAULT (' ') NOT NULL,
    [ShpCharge]          FLOAT (53)    CONSTRAINT [DF_EDContainer_ShpCharge] DEFAULT ((0)) NOT NULL,
    [ShpDate]            SMALLDATETIME CONSTRAINT [DF_EDContainer_ShpDate] DEFAULT ('01/01/1900') NOT NULL,
    [ShpTime]            CHAR (10)     CONSTRAINT [DF_EDContainer_ShpTime] DEFAULT (' ') NOT NULL,
    [ShpWeight]          FLOAT (53)    CONSTRAINT [DF_EDContainer_ShpWeight] DEFAULT ((0)) NOT NULL,
    [SurCharge]          FLOAT (53)    CONSTRAINT [DF_EDContainer_SurCharge] DEFAULT ((0)) NOT NULL,
    [TareFlag]           SMALLINT      CONSTRAINT [DF_EDContainer_TareFlag] DEFAULT ((0)) NOT NULL,
    [TareID]             CHAR (10)     CONSTRAINT [DF_EDContainer_TareID] DEFAULT (' ') NOT NULL,
    [TotBillCharge]      FLOAT (53)    CONSTRAINT [DF_EDContainer_TotBillCharge] DEFAULT ((0)) NOT NULL,
    [TotShipCharge]      FLOAT (53)    CONSTRAINT [DF_EDContainer_TotShipCharge] DEFAULT ((0)) NOT NULL,
    [TrackCharge]        FLOAT (53)    CONSTRAINT [DF_EDContainer_TrackCharge] DEFAULT ((0)) NOT NULL,
    [TrackingNbr]        CHAR (30)     CONSTRAINT [DF_EDContainer_TrackingNbr] DEFAULT (' ') NOT NULL,
    [UCC128]             CHAR (20)     CONSTRAINT [DF_EDContainer_UCC128] DEFAULT (' ') NOT NULL,
    [User1]              CHAR (30)     CONSTRAINT [DF_EDContainer_User1] DEFAULT (' ') NOT NULL,
    [User10]             SMALLDATETIME CONSTRAINT [DF_EDContainer_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]              CHAR (30)     CONSTRAINT [DF_EDContainer_User2] DEFAULT (' ') NOT NULL,
    [User3]              CHAR (30)     CONSTRAINT [DF_EDContainer_User3] DEFAULT (' ') NOT NULL,
    [User4]              CHAR (30)     CONSTRAINT [DF_EDContainer_User4] DEFAULT (' ') NOT NULL,
    [User5]              FLOAT (53)    CONSTRAINT [DF_EDContainer_User5] DEFAULT ((0)) NOT NULL,
    [User6]              FLOAT (53)    CONSTRAINT [DF_EDContainer_User6] DEFAULT ((0)) NOT NULL,
    [User7]              CHAR (10)     CONSTRAINT [DF_EDContainer_User7] DEFAULT (' ') NOT NULL,
    [User8]              CHAR (10)     CONSTRAINT [DF_EDContainer_User8] DEFAULT (' ') NOT NULL,
    [User9]              SMALLDATETIME CONSTRAINT [DF_EDContainer_User9] DEFAULT ('01/01/1900') NOT NULL,
    [Volume]             FLOAT (53)    CONSTRAINT [DF_EDContainer_Volume] DEFAULT ((0)) NOT NULL,
    [VolumeUOM]          CHAR (6)      CONSTRAINT [DF_EDContainer_VolumeUOM] DEFAULT (' ') NOT NULL,
    [Weight]             FLOAT (53)    CONSTRAINT [DF_EDContainer_Weight] DEFAULT ((0)) NOT NULL,
    [WeightUOM]          CHAR (6)      CONSTRAINT [DF_EDContainer_WeightUOM] DEFAULT (' ') NOT NULL,
    [Width]              FLOAT (53)    CONSTRAINT [DF_EDContainer_Width] DEFAULT ((0)) NOT NULL,
    [WidthUOM]           CHAR (6)      CONSTRAINT [DF_EDContainer_WidthUOM] DEFAULT (' ') NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [EDContainer0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [ShipperID] ASC, [ContainerID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [EDContainer1]
    ON [dbo].[EDContainer]([ContainerID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [EDContainer2]
    ON [dbo].[EDContainer]([TrackingNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [EDContainer3]
    ON [dbo].[EDContainer]([UCC128] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [EDContainer4]
    ON [dbo].[EDContainer]([BolNbr] ASC) WITH (FILLFACTOR = 90);

