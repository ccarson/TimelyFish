CREATE TABLE [dbo].[cftSiteSvcMgrAsn] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [EffectiveDate]   SMALLDATETIME NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [SiteContactID]   CHAR (6)      NOT NULL,
    [SvcMgrContactID] CHAR (6)      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [cftSiteSvcMgrAsn0] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

