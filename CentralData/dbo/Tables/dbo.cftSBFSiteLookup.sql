CREATE TABLE [dbo].[cftSBFSiteLookup] (
    [ContactID]     INT           NOT NULL,
    [SiteID]        INT           NOT NULL,
    [SBFSiteID]     INT           NULL,
    [EffectiveDate] SMALLDATETIME NOT NULL,
    [EndDate]       SMALLDATETIME NULL,
    [Crtd_dateTime] DATETIME      NOT NULL,
    [Crtd_User]     VARCHAR (20)  NOT NULL,
    [Lupd_dateTime] DATETIME      NULL,
    [Lupd_User]     VARCHAR (20)  NULL,
    CONSTRAINT [PK_cftSBFSiteLookup] PRIMARY KEY CLUSTERED ([ContactID] ASC, [SiteID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID])
);

