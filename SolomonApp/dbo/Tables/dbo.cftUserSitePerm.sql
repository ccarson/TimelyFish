CREATE TABLE [dbo].[cftUserSitePerm] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_UserID]   CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_UserID]   CHAR (10)     NOT NULL,
    [SiteContactID] CHAR (6)      NOT NULL,
    [UserId]        CHAR (47)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftUserSitePerm0] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [UserId] ASC) WITH (FILLFACTOR = 90)
);

