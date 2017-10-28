CREATE TABLE [dbo].[cft_REPORT_MARKET_MANAGER_LOAD_SUMMARY] (
    [ID]               INT           IDENTITY (1, 1) NOT NULL,
    [MarketManagerID]  CHAR (6)      NOT NULL,
    [MarketSaleTypeID] INT           NOT NULL,
    [PMLoadID]         CHAR (10)     NOT NULL,
    [Site]             CHAR (50)     NOT NULL,
    [PigGroupID]       CHAR (10)     NOT NULL,
    [KillDate]         SMALLDATETIME NOT NULL,
    [Packer]           CHAR (50)     NOT NULL,
    [BarnNbr]          CHAR (10)     NOT NULL,
    [BarnLoadID]       CHAR (10)     NOT NULL,
    [TotalHead]        INT           NOT NULL,
    [HotWgt]           FLOAT (53)    NOT NULL,
    [LiveWgtAvg]       FLOAT (53)    NOT NULL,
    [LiveWgtStdDev]    FLOAT (53)    NOT NULL,
    [WghtdStdDev]      FLOAT (53)    NOT NULL,
    [WghtdAvgWgt]      FLOAT (53)    NOT NULL,
    [PicYrWk]          CHAR (6)      NOT NULL,
    CONSTRAINT [PK_REPORT_MARKET_MANAGER_LOAD_SUMMARY] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100)
);

