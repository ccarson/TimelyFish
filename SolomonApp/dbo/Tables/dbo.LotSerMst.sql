CREATE TABLE [dbo].[LotSerMst] (
    [Cost]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]      SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]          CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [ExpDate]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [InvtID]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [LIFODate]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LotSerNbr]          CHAR (25)     DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]      SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]          CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr]      CHAR (25)     DEFAULT (' ') NOT NULL,
    [NoteID]             INT           DEFAULT ((0)) NOT NULL,
    [OrigQty]            FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PrjINQtyAlloc]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PrjINQtyAllocIN]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PrjINQtyAllocPORet] FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PrjINQtyAllocSO]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [PrjINQtyShipNotInv] FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAlloc]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocBM]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocIN]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocOther]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocPORet]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocProjIN]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocSD]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAllocSO]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAvail]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyOnHand]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyShipNotInv]      FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyWORlsedDemand]   FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [RcptDate]           SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future01]         CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]         CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]         INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]         INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [ShipConfirmQty]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [ShipContCode]       CHAR (20)     DEFAULT (' ') NOT NULL,
    [SiteID]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [Source]             CHAR (2)      DEFAULT (' ') NOT NULL,
    [SrcOrdNbr]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [Status]             CHAR (1)      DEFAULT ('A') NOT NULL,
    [StatusDate]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User1]              CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]              CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]              FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]              CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]              SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]              SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [WarrantyDate]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [LotSerMst0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [LotSerNbr] ASC, [SiteID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [LotSerMst1]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst10]
    ON [dbo].[LotSerMst]([LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst2]
    ON [dbo].[LotSerMst]([InvtID] ASC, [MfgrLotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst3]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [ExpDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst4]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [RcptDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst5]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [LIFODate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst6]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [Status] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst7]
    ON [dbo].[LotSerMst]([ShipContCode] ASC, [InvtID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst8]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [QtyAlloc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LotSerMst9]
    ON [dbo].[LotSerMst]([InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC, [Status] ASC)
    INCLUDE([QtyAllocIN], [QtyAllocSO], [QtyOnHand], [QtyShipNotInv], [QtyWORlsedDemand], [QtyAlloc], [QtyAllocBM], [QtyAllocPORet], [QtyAllocSD]) WITH (FILLFACTOR = 90);

