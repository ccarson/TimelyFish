CREATE TABLE [dbo].[cftInternalTrucker] (
    [ContactID]           CHAR (6)      NOT NULL,
    [Crtd_DateTime]       SMALLDATETIME NOT NULL,
    [Crtd_Prog]           CHAR (8)      NOT NULL,
    [Crtd_User]           CHAR (10)     NOT NULL,
    [DefaultPigTrailerID] CHAR (3)      NOT NULL,
    [Lupd_DateTime]       SMALLDATETIME NOT NULL,
    [Lupd_Prog]           CHAR (8)      NOT NULL,
    [Lupd_User]           CHAR (10)     NOT NULL,
    [StatusTypeID]        SMALLINT      NOT NULL,
    [TrackMiles]          SMALLINT      NOT NULL,
    [tstamp]              ROWVERSION    NULL,
    CONSTRAINT [cftInternalTrucker0] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

