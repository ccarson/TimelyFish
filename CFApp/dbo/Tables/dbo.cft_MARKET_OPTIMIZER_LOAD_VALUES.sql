CREATE TABLE [dbo].[cft_MARKET_OPTIMIZER_LOAD_VALUES] (
    [LoadID]    INT         NOT NULL,
    [LoadDay]   INT         NOT NULL,
    [Packer]    VARCHAR (2) NOT NULL,
    [LoadValue] INT         NULL,
    [PigWT]     INT         NULL,
    CONSTRAINT [PK_cft_MARKET_OPTIMIZER_LOAD_VALUES] PRIMARY KEY CLUSTERED ([LoadID] ASC, [LoadDay] ASC, [Packer] ASC) WITH (FILLFACTOR = 90)
);

