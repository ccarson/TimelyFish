CREATE TABLE [dbo].[cftSitePod] (
    [ContactID]       CHAR (10)     NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [EffectiveDate]   SMALLDATETIME NOT NULL,
    [EffectivePeriod] CHAR (6)      NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [PodID]           CHAR (3)      NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [cftSitePod0] PRIMARY KEY CLUSTERED ([ContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);

