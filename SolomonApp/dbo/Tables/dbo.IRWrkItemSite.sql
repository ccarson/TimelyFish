CREATE TABLE [dbo].[IRWrkItemSite] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DemandQty]     FLOAT (53)    NOT NULL,
    [FromSiteID]    CHAR (10)     NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Processed]     SMALLINT      NOT NULL,
    [S4Future01]    CHAR (30)     NOT NULL,
    [S4Future02]    CHAR (30)     NOT NULL,
    [S4Future03]    FLOAT (53)    NOT NULL,
    [S4Future04]    FLOAT (53)    NOT NULL,
    [S4Future05]    FLOAT (53)    NOT NULL,
    [S4Future06]    FLOAT (53)    NOT NULL,
    [S4Future07]    SMALLDATETIME NOT NULL,
    [S4Future08]    SMALLDATETIME NOT NULL,
    [S4Future09]    INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [SiteID]        CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User10]        SMALLDATETIME NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         CHAR (30)     NOT NULL,
    [User4]         CHAR (30)     NOT NULL,
    [User5]         FLOAT (53)    NOT NULL,
    [User6]         FLOAT (53)    NOT NULL,
    [User7]         CHAR (10)     NOT NULL,
    [User8]         CHAR (10)     NOT NULL,
    [User9]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [IRWrkItemSite0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IRWrkItemSite1]
    ON [dbo].[IRWrkItemSite]([FromSiteID] ASC) WITH (FILLFACTOR = 90);

