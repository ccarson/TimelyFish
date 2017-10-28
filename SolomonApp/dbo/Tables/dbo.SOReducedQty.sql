CREATE TABLE [dbo].[SOReducedQty] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [PlanQty]       FLOAT (53)    NOT NULL,
    [PlanReqDate]   SMALLDATETIME NOT NULL,
    [SchedQty]      FLOAT (53)    NOT NULL,
    [SchedReqDate]  SMALLDATETIME NOT NULL,
    [SiteID]        CHAR (10)     NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [SOReducedQty0]
    ON [dbo].[SOReducedQty]([InvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90);

