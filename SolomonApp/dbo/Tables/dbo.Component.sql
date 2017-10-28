CREATE TABLE [dbo].[Component] (
    [BomUsage]      CHAR (3)      CONSTRAINT [DF_Component_BomUsage] DEFAULT (' ') NOT NULL,
    [CmpnentID]     CHAR (30)     CONSTRAINT [DF_Component_CmpnentID] DEFAULT (' ') NOT NULL,
    [CmpnentQty]    FLOAT (53)    CONSTRAINT [DF_Component_CmpnentQty] DEFAULT ((0)) NOT NULL,
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_Component_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_Component_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_Component_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_Component_Crtd_User] DEFAULT (' ') NOT NULL,
    [Deviation]     CHAR (30)     CONSTRAINT [DF_Component_Deviation] DEFAULT (' ') NOT NULL,
    [EngrChgOrder]  CHAR (20)     CONSTRAINT [DF_Component_EngrChgOrder] DEFAULT (' ') NOT NULL,
    [ExplodeFlg]    CHAR (1)      CONSTRAINT [DF_Component_ExplodeFlg] DEFAULT (' ') NOT NULL,
    [KitID]         CHAR (30)     CONSTRAINT [DF_Component_KitID] DEFAULT (' ') NOT NULL,
    [KitSiteID]     CHAR (10)     CONSTRAINT [DF_Component_KitSiteID] DEFAULT (' ') NOT NULL,
    [KitStatus]     CHAR (1)      CONSTRAINT [DF_Component_KitStatus] DEFAULT (' ') NOT NULL,
    [LineID]        INT           CONSTRAINT [DF_Component_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]       SMALLINT      CONSTRAINT [DF_Component_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]       CHAR (5)      CONSTRAINT [DF_Component_LineRef] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_Component_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_Component_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_Component_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_Component_NoteID] DEFAULT ((0)) NOT NULL,
    [RtgStep]       CHAR (5)      CONSTRAINT [DF_Component_RtgStep] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_Component_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_Component_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_Component_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_Component_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_Component_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_Component_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_Component_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_Component_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_Component_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_Component_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_Component_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_Component_S4Future12] DEFAULT (' ') NOT NULL,
    [ScrapPct]      FLOAT (53)    CONSTRAINT [DF_Component_ScrapPct] DEFAULT ((0)) NOT NULL,
    [Sequence]      CHAR (5)      CONSTRAINT [DF_Component_Sequence] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_Component_SiteID] DEFAULT (' ') NOT NULL,
    [StartDate]     SMALLDATETIME CONSTRAINT [DF_Component_StartDate] DEFAULT ('01/01/1900') NOT NULL,
    [Status]        CHAR (1)      CONSTRAINT [DF_Component_Status] DEFAULT (' ') NOT NULL,
    [StdQty]        FLOAT (53)    CONSTRAINT [DF_Component_StdQty] DEFAULT ((0)) NOT NULL,
    [StockUsage]    CHAR (1)      CONSTRAINT [DF_Component_StockUsage] DEFAULT (' ') NOT NULL,
    [StopDate]      SMALLDATETIME CONSTRAINT [DF_Component_StopDate] DEFAULT ('01/01/1900') NOT NULL,
    [SubKitStatus]  CHAR (1)      CONSTRAINT [DF_Component_SubKitStatus] DEFAULT (' ') NOT NULL,
    [SupersededBy]  CHAR (30)     CONSTRAINT [DF_Component_SupersededBy] DEFAULT (' ') NOT NULL,
    [Supersedes]    CHAR (30)     CONSTRAINT [DF_Component_Supersedes] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_Component_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_Component_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_Component_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_Component_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_Component_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_Component_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_Component_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_Component_User8] DEFAULT ('01/01/1900') NOT NULL,
    [UTEFlag]       CHAR (10)     CONSTRAINT [DF_Component_UTEFlag] DEFAULT (' ') NOT NULL,
    [WONbr]         CHAR (10)     CONSTRAINT [DF_Component_WONbr] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [Component0] PRIMARY KEY CLUSTERED ([KitID] ASC, [KitSiteID] ASC, [KitStatus] ASC, [LineNbr] ASC, [CmpnentID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Component1]
    ON [dbo].[Component]([KitID] ASC, [CmpnentID] ASC, [SiteID] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Component2]
    ON [dbo].[Component]([KitID] ASC, [CmpnentID] ASC, [KitSiteID] ASC, [KitStatus] ASC, [SiteID] ASC, [Sequence] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Component3]
    ON [dbo].[Component]([KitID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Component4]
    ON [dbo].[Component]([CmpnentID] ASC, [SiteID] ASC, [Status] ASC, [KitStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Component5]
    ON [dbo].[Component]([CmpnentID] ASC, [SubKitStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Component6]
    ON [dbo].[Component]([CmpnentID] ASC, [KitStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Component7]
    ON [dbo].[Component]([KitID] ASC, [SiteID] ASC, [KitStatus] ASC, [CmpnentID] ASC, [Status] ASC) WITH (FILLFACTOR = 90);

