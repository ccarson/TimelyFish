CREATE TABLE [dbo].[cftSiteCap] (
    [BarnNbr]        CHAR (6)      NOT NULL,
    [Capacity]       SMALLINT      NOT NULL,
    [County]         CHAR (30)     NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [CurrentInv]     INT           NOT NULL,
    [FacilityDesc]   CHAR (30)     NOT NULL,
    [InvDate]        SMALLDATETIME NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [MktMgrName]     CHAR (50)     NOT NULL,
    [OwnerDesc]      CHAR (30)     NOT NULL,
    [SiteContactID]  CHAR (6)      NOT NULL,
    [SiteName]       CHAR (50)     NOT NULL,
    [SiteOwningCpny] CHAR (10)     NOT NULL,
    [State]          CHAR (3)      NOT NULL,
    [SvcMgrName]     CHAR (50)     NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [cftSiteCap0] PRIMARY KEY CLUSTERED ([BarnNbr] ASC, [SiteContactID] ASC) WITH (FILLFACTOR = 90)
);

