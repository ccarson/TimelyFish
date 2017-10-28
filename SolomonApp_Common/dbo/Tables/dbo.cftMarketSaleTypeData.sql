CREATE TABLE [dbo].[cftMarketSaleTypeData] (
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Description]      CHAR (30)     NOT NULL,
    [LoadTimeMinutes]  SMALLINT      NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [MarketSaleTypeID] CHAR (2)      NOT NULL,
    [NoteID]           INT           NOT NULL,
    [MarketTotalType]  CHAR (3)      NULL,
    [TrailerWashFlg]   SMALLINT      NOT NULL,
    [tstamp]           ROWVERSION    NULL,
    CONSTRAINT [cftMarketSaleTypeData0] PRIMARY KEY CLUSTERED ([MarketSaleTypeID] ASC, [Description] ASC) WITH (FILLFACTOR = 90)
);

