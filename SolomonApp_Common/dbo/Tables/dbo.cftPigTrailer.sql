CREATE TABLE [dbo].[cftPigTrailer] (
    [CompanyOwnedFlag]     SMALLINT      NOT NULL,
    [CpnyID]               CHAR (10)     NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME NOT NULL,
    [Crtd_Prog]            CHAR (8)      NOT NULL,
    [Crtd_User]            CHAR (10)     NOT NULL,
    [Description]          CHAR (30)     NOT NULL,
    [InternalRampFlag]     SMALLINT      NOT NULL,
    [Lupd_DateTime]        SMALLDATETIME NOT NULL,
    [Lupd_Prog]            CHAR (8)      NOT NULL,
    [Lupd_User]            CHAR (10)     NOT NULL,
    [PigTrailerID]         CHAR (3)      NOT NULL,
    [PigTrailerTypeID]     CHAR (2)      NOT NULL,
    [StatusTypeID]         SMALLINT      NOT NULL,
    [TrailerWashContactID] CHAR (6)      NOT NULL,
    [TruckWashFlag]        SMALLINT      NOT NULL,
    [tstamp]               ROWVERSION    NULL,
    CONSTRAINT [cftPigTrailer0] PRIMARY KEY CLUSTERED ([PigTrailerID] ASC) WITH (FILLFACTOR = 90)
);

