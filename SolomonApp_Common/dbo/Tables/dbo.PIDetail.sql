CREATE TABLE [dbo].[PIDetail] (
    [BookQty]         FLOAT (53)    CONSTRAINT [DF_PIDetail_BookQty] DEFAULT ((0)) NOT NULL,
    [CostCtr]         INT           CONSTRAINT [DF_PIDetail_CostCtr] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME CONSTRAINT [DF_PIDetail_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]       CHAR (8)      CONSTRAINT [DF_PIDetail_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]       CHAR (10)     CONSTRAINT [DF_PIDetail_Crtd_User] DEFAULT (' ') NOT NULL,
    [DateFreeze]      SMALLDATETIME CONSTRAINT [DF_PIDetail_DateFreeze] DEFAULT ('01/01/1900') NOT NULL,
    [ExtCostVariance] FLOAT (53)    CONSTRAINT [DF_PIDetail_ExtCostVariance] DEFAULT ((0)) NOT NULL,
    [InvtID]          CHAR (30)     CONSTRAINT [DF_PIDetail_InvtID] DEFAULT (' ') NOT NULL,
    [ItemDesc]        CHAR (60)     CONSTRAINT [DF_PIDetail_ItemDesc] DEFAULT (' ') NOT NULL,
    [LineID]          INT           CONSTRAINT [DF_PIDetail_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]         SMALLINT      CONSTRAINT [DF_PIDetail_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]         CHAR (5)      CONSTRAINT [DF_PIDetail_LineRef] DEFAULT (' ') NOT NULL,
    [LotOrSer]        CHAR (1)      CONSTRAINT [DF_PIDetail_LotOrSer] DEFAULT (' ') NOT NULL,
    [LotSerNbr]       CHAR (25)     CONSTRAINT [DF_PIDetail_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME CONSTRAINT [DF_PIDetail_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]       CHAR (8)      CONSTRAINT [DF_PIDetail_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]       CHAR (10)     CONSTRAINT [DF_PIDetail_LUpd_User] DEFAULT (' ') NOT NULL,
    [MsgNbr]          CHAR (4)      CONSTRAINT [DF_PIDetail_MsgNbr] DEFAULT (' ') NOT NULL,
    [NoteID]          INT           CONSTRAINT [DF_PIDetail_NoteID] DEFAULT ((0)) NOT NULL,
    [Number]          INT           CONSTRAINT [DF_PIDetail_Number] DEFAULT ((0)) NOT NULL,
    [PerClosed]       CHAR (6)      CONSTRAINT [DF_PIDetail_PerClosed] DEFAULT (' ') NOT NULL,
    [PhysQty]         FLOAT (53)    CONSTRAINT [DF_PIDetail_PhysQty] DEFAULT ((0)) NOT NULL,
    [PIID]            CHAR (10)     CONSTRAINT [DF_PIDetail_PIID] DEFAULT (' ') NOT NULL,
    [PIType]          CHAR (2)      CONSTRAINT [DF_PIDetail_PIType] DEFAULT (' ') NOT NULL,
    [S4Future01]      CHAR (30)     CONSTRAINT [DF_PIDetail_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]      CHAR (30)     CONSTRAINT [DF_PIDetail_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]      FLOAT (53)    CONSTRAINT [DF_PIDetail_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]      FLOAT (53)    CONSTRAINT [DF_PIDetail_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]      FLOAT (53)    CONSTRAINT [DF_PIDetail_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]      FLOAT (53)    CONSTRAINT [DF_PIDetail_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]      SMALLDATETIME CONSTRAINT [DF_PIDetail_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]      SMALLDATETIME CONSTRAINT [DF_PIDetail_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]      INT           CONSTRAINT [DF_PIDetail_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]      INT           CONSTRAINT [DF_PIDetail_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]      CHAR (10)     CONSTRAINT [DF_PIDetail_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]      CHAR (10)     CONSTRAINT [DF_PIDetail_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]          CHAR (10)     CONSTRAINT [DF_PIDetail_SiteID] DEFAULT (' ') NOT NULL,
    [SpecificCostID]  CHAR (25)     CONSTRAINT [DF_PIDetail_SpecificCostID] DEFAULT (' ') NOT NULL,
    [Status]          CHAR (1)      CONSTRAINT [DF_PIDetail_Status] DEFAULT (' ') NOT NULL,
    [TranDate]        SMALLDATETIME CONSTRAINT [DF_PIDetail_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [Unit]            CHAR (10)     CONSTRAINT [DF_PIDetail_Unit] DEFAULT (' ') NOT NULL,
    [UnitCost]        FLOAT (53)    CONSTRAINT [DF_PIDetail_UnitCost] DEFAULT ((0)) NOT NULL,
    [User1]           CHAR (30)     CONSTRAINT [DF_PIDetail_User1] DEFAULT (' ') NOT NULL,
    [User2]           CHAR (30)     CONSTRAINT [DF_PIDetail_User2] DEFAULT (' ') NOT NULL,
    [User3]           FLOAT (53)    CONSTRAINT [DF_PIDetail_User3] DEFAULT ((0)) NOT NULL,
    [User4]           FLOAT (53)    CONSTRAINT [DF_PIDetail_User4] DEFAULT ((0)) NOT NULL,
    [User5]           CHAR (10)     CONSTRAINT [DF_PIDetail_User5] DEFAULT (' ') NOT NULL,
    [User6]           CHAR (10)     CONSTRAINT [DF_PIDetail_User6] DEFAULT (' ') NOT NULL,
    [User7]           SMALLDATETIME CONSTRAINT [DF_PIDetail_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]           SMALLDATETIME CONSTRAINT [DF_PIDetail_User8] DEFAULT ('01/01/1900') NOT NULL,
    [ValMthd]         CHAR (1)      CONSTRAINT [DF_PIDetail_ValMthd] DEFAULT (' ') NOT NULL,
    [WhseLoc]         CHAR (10)     CONSTRAINT [DF_PIDetail_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [PIDetail0] PRIMARY KEY CLUSTERED ([PIID] ASC, [Number] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PIDetail1]
    ON [dbo].[PIDetail]([PIID] ASC, [InvtID] ASC, [LotSerNbr] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PIDetail2]
    ON [dbo].[PIDetail]([PIID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PIDetail3]
    ON [dbo].[PIDetail]([InvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90);

