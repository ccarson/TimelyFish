CREATE TABLE [dbo].[cft_MARKET_OPTIMIZER_LOG] (
    [LogMessage]      VARCHAR (255) NOT NULL,
    [CreatedDateTime] DATETIME      CONSTRAINT [DF_cft_MARKET_OPTIMIZER_LOG_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_cft_market_optimizer_log] PRIMARY KEY CLUSTERED ([LogMessage] ASC, [CreatedDateTime] ASC) WITH (FILLFACTOR = 90)
);

