CREATE TABLE [dbo].[cftMillSite] (
    [CpnyId]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DelChg]        FLOAT (53)    NOT NULL,
    [FileType]      CHAR (1)      NOT NULL,
    [GLSub]         CHAR (24)     NOT NULL,
    [GMChg]         FLOAT (53)    NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MileRate]      FLOAT (53)    NOT NULL,
    [MillId]        CHAR (6)      NOT NULL,
    [SiteId]        CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         INT           NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftMillSite0] PRIMARY KEY CLUSTERED ([MillId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftMillSite1]
    ON [dbo].[cftMillSite]([CpnyId] ASC, [MillId] ASC) WITH (FILLFACTOR = 90);

