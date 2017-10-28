CREATE TABLE [dbo].[SOPlan] (
    [BuildAssyTime]     SMALLINT      DEFAULT ((0)) NOT NULL,
    [BuildAvailDate]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [CompLeadTime]      SMALLINT      DEFAULT ((0)) NOT NULL,
    [CpnyID]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [DisplaySeq]        CHAR (36)     DEFAULT (' ') NOT NULL,
    [FixedAlloc]        SMALLINT      DEFAULT ((0)) NOT NULL,
    [Hold]              SMALLINT      DEFAULT ((0)) NOT NULL,
    [InvtID]            CHAR (30)     DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [NoteID]            INT           DEFAULT ((0)) NOT NULL,
    [PlanDate]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [PlanRef]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [PlanType]          CHAR (2)      DEFAULT (' ') NOT NULL,
    [POAllocRef]        CHAR (5)      DEFAULT (' ') NOT NULL,
    [POLineRef]         CHAR (5)      DEFAULT (' ') NOT NULL,
    [PONbr]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [Priority]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [PriorityDate]      SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [PrioritySeq]       INT           DEFAULT ((0)) NOT NULL,
    [PriorityTime]      SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [PromDate]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [PromShipDate]      SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Qty]               FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyAvail]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [QtyShip]           FLOAT (53)    DEFAULT ((0)) NOT NULL,
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
    [ShelfLife]         INT           DEFAULT ((0)) NOT NULL,
    [ShipCmplt]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [SiteID]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [SOETADate]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SOLineRef]         CHAR (5)      DEFAULT (' ') NOT NULL,
    [SOOrdNbr]          CHAR (15)     DEFAULT (' ') NOT NULL,
    [SOReqDate]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SOReqPickDate]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SOReqShipDate]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SOSchedRef]        CHAR (5)      DEFAULT (' ') NOT NULL,
    [SOShipperID]       CHAR (15)     DEFAULT (' ') NOT NULL,
    [SOShipperLineRef]  CHAR (5)      DEFAULT (' ') NOT NULL,
    [SOShipViaID]       CHAR (15)     DEFAULT (' ') NOT NULL,
    [SOTransitTime]     SMALLINT      DEFAULT ((0)) NOT NULL,
    [SOWeekendDelivery] SMALLINT      DEFAULT ((0)) NOT NULL,
    [User1]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User10]            SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User2]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User4]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User5]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User6]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User7]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [User8]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [User9]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [WOBTLineRef]       CHAR (5)      DEFAULT (' ') NOT NULL,
    [WOMRLineRef]       CHAR (5)      DEFAULT (' ') NOT NULL,
    [WONbr]             CHAR (16)     DEFAULT (' ') NOT NULL,
    [WOTask]            CHAR (32)     DEFAULT (' ') NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [SOPlan0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [SiteID] ASC, [PlanDate] ASC, [PlanType] ASC, [PlanRef] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SOPlan1]
    ON [dbo].[SOPlan]([DisplaySeq] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPlan2]
    ON [dbo].[SOPlan]([CpnyID] ASC, [SOOrdNbr] ASC, [SOLineRef] ASC, [SOSchedRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPlan3]
    ON [dbo].[SOPlan]([CpnyID] ASC, [SOShipperID] ASC, [SOShipperLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPlan4]
    ON [dbo].[SOPlan]([CpnyID] ASC, [PONbr] ASC, [POLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPlan5]
    ON [dbo].[SOPlan]([InvtID] ASC, [SiteID] ASC, [PlanRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPlan6]
    ON [dbo].[SOPlan]([InvtID] ASC, [SiteID] ASC, [PlanType] ASC, [CpnyID] ASC, [SOShipperID] ASC, [SOShipperLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SOPlan7]
    ON [dbo].[SOPlan]([CpnyID] ASC, [WONbr] ASC, [WOTask] ASC, [WOMRLineRef] ASC, [WOBTLineRef] ASC) WITH (FILLFACTOR = 90);

