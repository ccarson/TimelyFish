CREATE TABLE [dbo].[POAlloc] (
    [AllocRef]       CHAR (5)      CONSTRAINT [DF_POAlloc_AllocRef] DEFAULT (' ') NOT NULL,
    [BOMLineRef]     CHAR (5)      CONSTRAINT [DF_POAlloc_BOMLineRef] DEFAULT (' ') NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_POAlloc_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_POAlloc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_POAlloc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_POAlloc_Crtd_User] DEFAULT (' ') NOT NULL,
    [DocType]        CHAR (1)      CONSTRAINT [DF_POAlloc_DocType] DEFAULT (' ') NOT NULL,
    [EmpID]          CHAR (10)     CONSTRAINT [DF_POAlloc_EmpID] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_POAlloc_InvtID] DEFAULT (' ') NOT NULL,
    [Labor_Class_Cd] CHAR (4)      CONSTRAINT [DF_POAlloc_Labor_Class_Cd] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_POAlloc_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_POAlloc_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_POAlloc_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_POAlloc_NoteID] DEFAULT ((0)) NOT NULL,
    [POLineRef]      CHAR (5)      CONSTRAINT [DF_POAlloc_POLineRef] DEFAULT (' ') NOT NULL,
    [PONbr]          CHAR (10)     CONSTRAINT [DF_POAlloc_PONbr] DEFAULT (' ') NOT NULL,
    [Project]        CHAR (16)     CONSTRAINT [DF_POAlloc_Project] DEFAULT (' ') NOT NULL,
    [PurchAcct]      CHAR (10)     CONSTRAINT [DF_POAlloc_PurchAcct] DEFAULT (' ') NOT NULL,
    [PurchSub]       CHAR (24)     CONSTRAINT [DF_POAlloc_PurchSub] DEFAULT (' ') NOT NULL,
    [PurchUnit]      CHAR (6)      CONSTRAINT [DF_POAlloc_PurchUnit] DEFAULT (' ') NOT NULL,
    [QtyAlloc]       FLOAT (53)    CONSTRAINT [DF_POAlloc_QtyAlloc] DEFAULT ((0)) NOT NULL,
    [QtyOrd]         FLOAT (53)    CONSTRAINT [DF_POAlloc_QtyOrd] DEFAULT ((0)) NOT NULL,
    [QtyRcvd]        FLOAT (53)    CONSTRAINT [DF_POAlloc_QtyRcvd] DEFAULT ((0)) NOT NULL,
    [QtyReturned]    FLOAT (53)    CONSTRAINT [DF_POAlloc_QtyReturned] DEFAULT ((0)) NOT NULL,
    [QtyShip]        FLOAT (53)    CONSTRAINT [DF_POAlloc_QtyShip] DEFAULT ((0)) NOT NULL,
    [QtyVouched]     FLOAT (53)    CONSTRAINT [DF_POAlloc_QtyVouched] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_POAlloc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_POAlloc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_POAlloc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_POAlloc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_POAlloc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_POAlloc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_POAlloc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_POAlloc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_POAlloc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_POAlloc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_POAlloc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_POAlloc_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteId]         CHAR (10)     CONSTRAINT [DF_POAlloc_SiteId] DEFAULT (' ') NOT NULL,
    [SOLineRef]      CHAR (5)      CONSTRAINT [DF_POAlloc_SOLineRef] DEFAULT (' ') NOT NULL,
    [SOOrdNbr]       CHAR (15)     CONSTRAINT [DF_POAlloc_SOOrdNbr] DEFAULT (' ') NOT NULL,
    [SOSchedRef]     CHAR (5)      CONSTRAINT [DF_POAlloc_SOSchedRef] DEFAULT (' ') NOT NULL,
    [SOType]         CHAR (2)      CONSTRAINT [DF_POAlloc_SOType] DEFAULT (' ') NOT NULL,
    [Task]           CHAR (32)     CONSTRAINT [DF_POAlloc_Task] DEFAULT (' ') NOT NULL,
    [UnitCnvFact]    FLOAT (53)    CONSTRAINT [DF_POAlloc_UnitCnvFact] DEFAULT ((0)) NOT NULL,
    [UnitMultDiv]    CHAR (1)      CONSTRAINT [DF_POAlloc_UnitMultDiv] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_POAlloc_User1] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_POAlloc_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_POAlloc_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_POAlloc_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_POAlloc_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_POAlloc_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_POAlloc_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_POAlloc_User8] DEFAULT ('01/01/1900') NOT NULL,
    [WOCostType]     CHAR (2)      CONSTRAINT [DF_POAlloc_WOCostType] DEFAULT (' ') NOT NULL,
    [WOLineRef]      CHAR (5)      CONSTRAINT [DF_POAlloc_WOLineRef] DEFAULT (' ') NOT NULL,
    [WONbr]          CHAR (16)     CONSTRAINT [DF_POAlloc_WONbr] DEFAULT (' ') NOT NULL,
    [WOStepNbr]      CHAR (5)      CONSTRAINT [DF_POAlloc_WOStepNbr] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [POAlloc0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [PONbr] ASC, [POLineRef] ASC, [AllocRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [POAlloc1]
    ON [dbo].[POAlloc]([CpnyID] ASC, [SOOrdNbr] ASC, [SOLineRef] ASC, [SOSchedRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POAlloc3]
    ON [dbo].[POAlloc]([PONbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POAlloc4]
    ON [dbo].[POAlloc]([PONbr] ASC, [POLineRef] ASC) WITH (FILLFACTOR = 90);

