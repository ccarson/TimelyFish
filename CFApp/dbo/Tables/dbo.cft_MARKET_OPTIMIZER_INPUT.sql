CREATE TABLE [dbo].[cft_MARKET_OPTIMIZER_INPUT] (
    [LID]             INT          NOT NULL,
    [QTY]             INT          NULL,
    [OB]              INT          NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_MARKET_OPTIMIZER_INPUT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [SiteName]        VARCHAR (50) NULL
);

