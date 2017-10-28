CREATE TABLE [dbo].[cftOwnerBarnDetail] (
    [BarnNbr]          CHAR (6)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [OwnerContactID]   CHAR (6)      NOT NULL,
    [PercentOwnership] FLOAT (53)    NOT NULL,
    [SiteContactID]    CHAR (6)      NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftOwnerBarnDetail0] PRIMARY KEY CLUSTERED ([OwnerContactID] ASC, [SiteContactID] ASC, [BarnNbr] ASC) WITH (FILLFACTOR = 90)
);

