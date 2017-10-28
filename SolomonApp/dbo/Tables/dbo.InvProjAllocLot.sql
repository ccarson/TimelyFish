CREATE TABLE [dbo].[InvProjAllocLot] (
    [AllocationLineID]  INT           DEFAULT ((0)) NOT NULL,
    [AllocationLineRef] CHAR (5)      DEFAULT (' ') NOT NULL,
    [AllocationQty]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [CpnyID]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]         CHAR (47)     DEFAULT (' ') NOT NULL,
    [InvtID]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [LotSerNbr]         CHAR (25)     DEFAULT (' ') NOT NULL,
    [LotSerRef]         CHAR (5)      DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]         CHAR (47)     DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr]     CHAR (25)     DEFAULT (' ') NOT NULL,
    [ProjectID]         CHAR (16)     DEFAULT (' ') NOT NULL,
    [QtyRemainToIssue]  FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future01]        CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]        CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]        INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]        INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [SiteID]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [SpecificCostID]    CHAR (25)     DEFAULT (' ') NOT NULL,
    [SrcDate]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SrcLineRef]        CHAR (5)      DEFAULT (' ') NOT NULL,
    [SrcNbr]            CHAR (15)     DEFAULT (' ') NOT NULL,
    [SrcType]           CHAR (3)      DEFAULT (' ') NOT NULL,
    [TaskID]            CHAR (32)     DEFAULT (' ') NOT NULL,
    [UnitDesc]          CHAR (6)      DEFAULT (' ') NOT NULL,
    [User1]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [InvProjAllocLot0] PRIMARY KEY CLUSTERED ([SrcType] ASC, [SrcNbr] ASC, [SrcLineRef] ASC, [LotSerNbr] ASC, [LotSerRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [InvProjAllocLot1]
    ON [dbo].[InvProjAllocLot]([InvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAllocLot2]
    ON [dbo].[InvProjAllocLot]([ProjectID] ASC, [TaskID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAllocLot3]
    ON [dbo].[InvProjAllocLot]([InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAllocLot4]
    ON [dbo].[InvProjAllocLot]([CpnyID] ASC, [InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAllocLot5]
    ON [dbo].[InvProjAllocLot]([InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [InvProjAllocLot6]
    ON [dbo].[InvProjAllocLot]([InvtID] ASC, [SiteID] ASC, [ProjectID] ASC, [TaskID] ASC, [WhseLoc] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);

