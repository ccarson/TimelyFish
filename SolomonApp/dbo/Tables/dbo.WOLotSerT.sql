CREATE TABLE [dbo].[WOLotSerT] (
    [BatNbr]            CHAR (10)     CONSTRAINT [DF_WOLotSerT_BatNbr] DEFAULT (' ') NOT NULL,
    [CpnyID]            CHAR (10)     CONSTRAINT [DF_WOLotSerT_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME CONSTRAINT [DF_WOLotSerT_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]         CHAR (8)      CONSTRAINT [DF_WOLotSerT_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_Time]         SMALLDATETIME CONSTRAINT [DF_WOLotSerT_Crtd_Time] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_User]         CHAR (10)     CONSTRAINT [DF_WOLotSerT_Crtd_User] DEFAULT (' ') NOT NULL,
    [ExpDate]           SMALLDATETIME CONSTRAINT [DF_WOLotSerT_ExpDate] DEFAULT ('01/01/1900') NOT NULL,
    [INTranLineRef]     CHAR (5)      CONSTRAINT [DF_WOLotSerT_INTranLineRef] DEFAULT (' ') NOT NULL,
    [InvtID]            CHAR (30)     CONSTRAINT [DF_WOLotSerT_InvtID] DEFAULT (' ') NOT NULL,
    [InvtMult]          SMALLINT      CONSTRAINT [DF_WOLotSerT_InvtMult] DEFAULT ((0)) NOT NULL,
    [LineNbr]           SMALLINT      CONSTRAINT [DF_WOLotSerT_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]           CHAR (5)      CONSTRAINT [DF_WOLotSerT_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerNbr]         CHAR (25)     CONSTRAINT [DF_WOLotSerT_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LotSerTRecordID]   INT           CONSTRAINT [DF_WOLotSerT_LotSerTRecordID] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME CONSTRAINT [DF_WOLotSerT_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]         CHAR (8)      CONSTRAINT [DF_WOLotSerT_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUPd_Time]         SMALLDATETIME CONSTRAINT [DF_WOLotSerT_LUPd_Time] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_User]         CHAR (10)     CONSTRAINT [DF_WOLotSerT_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr]     CHAR (25)     CONSTRAINT [DF_WOLotSerT_MfgrLotSerNbr] DEFAULT (' ') NOT NULL,
    [NoteID]            INT           CONSTRAINT [DF_WOLotSerT_NoteID] DEFAULT ((0)) NOT NULL,
    [PJTK_Key]          CHAR (24)     CONSTRAINT [DF_WOLotSerT_PJTK_Key] DEFAULT (' ') NOT NULL,
    [PJTKBatch_ID]      CHAR (10)     CONSTRAINT [DF_WOLotSerT_PJTKBatch_ID] DEFAULT (' ') NOT NULL,
    [PJTKDetail_Num]    CHAR (6)      CONSTRAINT [DF_WOLotSerT_PJTKDetail_Num] DEFAULT (' ') NOT NULL,
    [PJTKFiscalNo]      CHAR (6)      CONSTRAINT [DF_WOLotSerT_PJTKFiscalNo] DEFAULT (' ') NOT NULL,
    [PJTKSystem_Cd]     CHAR (2)      CONSTRAINT [DF_WOLotSerT_PJTKSystem_Cd] DEFAULT (' ') NOT NULL,
    [Qty]               FLOAT (53)    CONSTRAINT [DF_WOLotSerT_Qty] DEFAULT ((0)) NOT NULL,
    [QtyTransferToDate] FLOAT (53)    CONSTRAINT [DF_WOLotSerT_QtyTransferToDate] DEFAULT ((0)) NOT NULL,
    [RecordID]          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [S4Future01]        CHAR (30)     CONSTRAINT [DF_WOLotSerT_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]        CHAR (30)     CONSTRAINT [DF_WOLotSerT_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]        FLOAT (53)    CONSTRAINT [DF_WOLotSerT_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]        FLOAT (53)    CONSTRAINT [DF_WOLotSerT_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]        FLOAT (53)    CONSTRAINT [DF_WOLotSerT_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]        FLOAT (53)    CONSTRAINT [DF_WOLotSerT_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]        SMALLDATETIME CONSTRAINT [DF_WOLotSerT_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]        SMALLDATETIME CONSTRAINT [DF_WOLotSerT_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]        INT           CONSTRAINT [DF_WOLotSerT_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]        INT           CONSTRAINT [DF_WOLotSerT_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]        CHAR (10)     CONSTRAINT [DF_WOLotSerT_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]        CHAR (10)     CONSTRAINT [DF_WOLotSerT_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipContCode]      CHAR (20)     CONSTRAINT [DF_WOLotSerT_ShipContCode] DEFAULT (' ') NOT NULL,
    [SiteID]            CHAR (10)     CONSTRAINT [DF_WOLotSerT_SiteID] DEFAULT (' ') NOT NULL,
    [Status]            CHAR (1)      CONSTRAINT [DF_WOLotSerT_Status] DEFAULT (' ') NOT NULL,
    [TaskID]            CHAR (32)     CONSTRAINT [DF_WOLotSerT_TaskID] DEFAULT (' ') NOT NULL,
    [TranDate]          SMALLDATETIME CONSTRAINT [DF_WOLotSerT_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TranLineRef]       CHAR (5)      CONSTRAINT [DF_WOLotSerT_TranLineRef] DEFAULT (' ') NOT NULL,
    [TranSDType]        CHAR (2)      CONSTRAINT [DF_WOLotSerT_TranSDType] DEFAULT (' ') NOT NULL,
    [TranSrcLineRef]    CHAR (5)      CONSTRAINT [DF_WOLotSerT_TranSrcLineRef] DEFAULT (' ') NOT NULL,
    [TranType]          CHAR (5)      CONSTRAINT [DF_WOLotSerT_TranType] DEFAULT (' ') NOT NULL,
    [User1]             CHAR (30)     CONSTRAINT [DF_WOLotSerT_User1] DEFAULT (' ') NOT NULL,
    [User10]            CHAR (30)     CONSTRAINT [DF_WOLotSerT_User10] DEFAULT (' ') NOT NULL,
    [User2]             CHAR (30)     CONSTRAINT [DF_WOLotSerT_User2] DEFAULT (' ') NOT NULL,
    [User3]             FLOAT (53)    CONSTRAINT [DF_WOLotSerT_User3] DEFAULT ((0)) NOT NULL,
    [User4]             FLOAT (53)    CONSTRAINT [DF_WOLotSerT_User4] DEFAULT ((0)) NOT NULL,
    [User5]             CHAR (10)     CONSTRAINT [DF_WOLotSerT_User5] DEFAULT (' ') NOT NULL,
    [User6]             CHAR (10)     CONSTRAINT [DF_WOLotSerT_User6] DEFAULT (' ') NOT NULL,
    [User7]             SMALLDATETIME CONSTRAINT [DF_WOLotSerT_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]             SMALLDATETIME CONSTRAINT [DF_WOLotSerT_User8] DEFAULT ('01/01/1900') NOT NULL,
    [User9]             CHAR (30)     CONSTRAINT [DF_WOLotSerT_User9] DEFAULT (' ') NOT NULL,
    [WarrantyDate]      SMALLDATETIME CONSTRAINT [DF_WOLotSerT_WarrantyDate] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]           CHAR (10)     CONSTRAINT [DF_WOLotSerT_WhseLoc] DEFAULT (' ') NOT NULL,
    [WONbr]             CHAR (16)     CONSTRAINT [DF_WOLotSerT_WONbr] DEFAULT (' ') NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [WOLotSerT0] PRIMARY KEY CLUSTERED ([LotSerNbr] ASC, [RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [WOLotSerT1]
    ON [dbo].[WOLotSerT]([WONbr] ASC, [TaskID] ASC, [TranSDType] ASC, [TranLineRef] ASC, [TranType] ASC, [PJTK_Key] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WOLotSerT2]
    ON [dbo].[WOLotSerT]([CpnyID] ASC, [BatNbr] ASC, [TranSDType] ASC, [TranLineRef] ASC, [TranType] ASC, [PJTK_Key] ASC, [LineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WOLotSerT3]
    ON [dbo].[WOLotSerT]([WhseLoc] ASC, [InvtID] ASC, [SiteID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);

