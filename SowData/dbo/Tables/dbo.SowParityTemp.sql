CREATE TABLE [dbo].[SowParityTemp] (
    [FarmID]              VARCHAR (8)   NOT NULL,
    [SowID]               VARCHAR (12)  NOT NULL,
    [EffectiveDate]       SMALLDATETIME NOT NULL,
    [Parity]              SMALLINT      NOT NULL,
    [EffectiveWeekOfDate] SMALLDATETIME NULL,
    CONSTRAINT [PK_SowParityTemp] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC, [EffectiveDate] ASC, [Parity] ASC) WITH (FILLFACTOR = 90)
);

