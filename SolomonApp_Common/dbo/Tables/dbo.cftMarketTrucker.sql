CREATE TABLE [dbo].[cftMarketTrucker] (
    [ContactID]        CHAR (6)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [MarketTruckerID]  CHAR (6)      NOT NULL,
    [PigTrailerTypeID] CHAR (2)      NOT NULL,
    [StatusTypeID]     SMALLINT      NOT NULL,
    [TruckNbr]         CHAR (4)      NOT NULL,
    [VendID]           CHAR (15)     NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftMarketTrucker0] PRIMARY KEY CLUSTERED ([MarketTruckerID] ASC) WITH (FILLFACTOR = 90)
);

