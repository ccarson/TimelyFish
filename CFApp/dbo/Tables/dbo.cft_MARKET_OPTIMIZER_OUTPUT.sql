CREATE TABLE [dbo].[cft_MARKET_OPTIMIZER_OUTPUT] (
    [loadID]          INT         NOT NULL,
    [day]             INT         NOT NULL,
    [packer]          VARCHAR (3) NULL,
    [CreatedDateTime] DATETIME    CONSTRAINT [DF_cft_MARKET_OPTIMIZER_OUTPUT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [EstimatedWgt]    INT         NULL
);

