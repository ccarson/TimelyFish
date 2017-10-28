CREATE TABLE [dbo].[cftMktMgrAssign] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [EffectiveDate]   SMALLDATETIME NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [MktMgrContactID] CHAR (6)      NOT NULL,
    [SiteContactID]   CHAR (6)      NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftMktMgrAssign0] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

