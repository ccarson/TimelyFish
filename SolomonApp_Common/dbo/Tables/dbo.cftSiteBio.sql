CREATE TABLE [dbo].[cftSiteBio] (
    [BioSecurityLevel] CHAR (20)     NULL,
    [Challenge]        CHAR (40)     NULL,
    [ContactID]        CHAR (6)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_User]        CHAR (50)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NULL,
    [Lupd_User]        CHAR (50)     NULL,
    [SiteID]           CHAR (4)      NOT NULL,
    CONSTRAINT [cftSiteBio0] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

