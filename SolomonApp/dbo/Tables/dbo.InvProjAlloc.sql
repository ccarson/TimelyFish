CREATE TABLE [dbo].[InvProjAlloc] (
    [CpnyID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]        CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]        CHAR (47)     DEFAULT (' ') NOT NULL,
    [InvtID]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]        CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]        CHAR (47)     DEFAULT (' ') NOT NULL,
    [OrdNbr]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [PerNbr]           CHAR (6)      DEFAULT (' ') NOT NULL,
    [PO_QtyOrd]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PO_UnitCost]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PO_UOM]           CHAR (6)      DEFAULT (' ') NOT NULL,
    [POLineRef]        CHAR (5)      DEFAULT (' ') NOT NULL,
    [PONbr]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [ProjectID]        CHAR (16)     DEFAULT (' ') NOT NULL,
    [QtyAllocated]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyRemainToIssue] FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future01]       CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]       CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]       FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]       INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]       INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [SiteID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [SrcDate]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SrcLineRef]       CHAR (5)      DEFAULT (' ') NOT NULL,
    [SrcNbr]           CHAR (15)     DEFAULT (' ') NOT NULL,
    [SrcType]          CHAR (3)      DEFAULT (' ') NOT NULL,
    [TaskID]           CHAR (32)     DEFAULT (' ') NOT NULL,
    [UnitCost]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [UnitDesc]         CHAR (6)      DEFAULT (' ') NOT NULL,
    [User1]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [WIP_COGS_Acct]    CHAR (10)     DEFAULT (' ') NOT NULL,
    [WIP_COGS_Sub]     CHAR (24)     DEFAULT (' ') NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [InvProjAlloc0] PRIMARY KEY CLUSTERED ([SrcType] ASC, [SrcNbr] ASC, [SrcLineRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [InvProjAlloc1]
    ON [dbo].[InvProjAlloc]([InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAlloc2]
    ON [dbo].[InvProjAlloc]([ProjectID] ASC, [TaskID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAlloc3]
    ON [dbo].[InvProjAlloc]([InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAlloc4]
    ON [dbo].[InvProjAlloc]([CpnyID] ASC, [InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAlloc5]
    ON [dbo].[InvProjAlloc]([InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);

