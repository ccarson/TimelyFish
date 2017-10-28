CREATE TABLE [dbo].[cft_MARKET_DRIVER_LOAD_INFORMATION] (
    [PMLoadID]         CHAR (10)     NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [RefNbr]           CHAR (10)     NOT NULL,
    [SaleDate]         SMALLDATETIME NULL,
    [SiteContactID]    CHAR (6)      NULL,
    [Site]             CHAR (50)     NULL,
    [PkrContactID]     CHAR (6)      NULL,
    [Packer]           CHAR (50)     NULL,
    [TaskID]           CHAR (32)     NULL,
    [SaleTypeID]       CHAR (2)      NULL,
    [PigTypeID]        CHAR (2)      NOT NULL,
    [MarketSaleTypeID] CHAR (2)      NOT NULL,
    [MovementDate]     SMALLDATETIME NOT NULL,
    [PICYear_Week]     CHAR (30)     NULL,
    [TruckerContactID] CHAR (6)      NOT NULL,
    [Trucker]          CHAR (50)     NULL,
    [EstimatedQty]     SMALLINT      NULL,
    [DetailTypeID]     CHAR (2)      NULL,
    [Qty]              SMALLINT      NULL,
    [WgtLive]          FLOAT (53)    NULL
);

