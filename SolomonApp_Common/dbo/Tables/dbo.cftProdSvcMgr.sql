CREATE TABLE [dbo].[cftProdSvcMgr] (
    [Crtd_DateTime]       SMALLDATETIME NOT NULL,
    [Crtd_Prog]           CHAR (8)      NOT NULL,
    [Crtd_User]           CHAR (10)     NOT NULL,
    [EffectiveDate]       SMALLDATETIME NOT NULL,
    [Lupd_DateTime]       SMALLDATETIME NOT NULL,
    [Lupd_Prog]           CHAR (8)      NOT NULL,
    [Lupd_User]           CHAR (10)     NOT NULL,
    [ProdSvcMgrContactID] CHAR (6)      NOT NULL,
    [SiteContactID]       CHAR (6)      NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [pk_cftProdSvcMgr] PRIMARY KEY CLUSTERED ([EffectiveDate] ASC, [SiteContactID] ASC, [tstamp] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftProdSvcMgr0]
    ON [dbo].[cftProdSvcMgr]([EffectiveDate] ASC, [SiteContactID] ASC) WITH (FILLFACTOR = 90);

