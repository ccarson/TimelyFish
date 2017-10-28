CREATE TABLE [dbo].[cftUserDefaults] (
    [BranchID]      CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_UserID]   CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_UserID]   CHAR (10)     NOT NULL,
    [SiteID]        CHAR (10)     NOT NULL,
    [UserId]        CHAR (47)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftUserDefaults0] PRIMARY KEY CLUSTERED ([UserId] ASC) WITH (FILLFACTOR = 90)
);

