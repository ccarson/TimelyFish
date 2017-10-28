CREATE TABLE [dbo].[cftPacker] (
    [CertFlg]          SMALLINT      NOT NULL,
    [ContactID]        CHAR (6)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Culls]            SMALLINT      NOT NULL,
    [CustID]           CHAR (15)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [MaxNbrLoads]      SMALLINT      NOT NULL,
    [PrimaryPacker]    SMALLINT      NOT NULL,
    [TimeBetweenLoads] SMALLINT      NOT NULL,
    [TrackTotals]      SMALLINT      NOT NULL,
    [TrkPaidFlg]       SMALLINT      NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftPacker0] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

