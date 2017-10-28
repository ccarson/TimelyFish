CREATE TABLE [dbo].[SowParity_remove] (
    [FarmID]              VARCHAR (8)   NOT NULL,
    [SowID]               VARCHAR (12)  NOT NULL,
    [EffectiveDate]       SMALLDATETIME NOT NULL,
    [Parity]              SMALLINT      CONSTRAINT [DF_SowParity_Parity] DEFAULT (0) NOT NULL,
    [EffectiveWeekOfDate] SMALLDATETIME NULL,
    CONSTRAINT [PK_SowParity] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC, [EffectiveDate] ASC, [Parity] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idxSowParity_FarmID]
    ON [dbo].[SowParity_remove]([FarmID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowParity_SowID]
    ON [dbo].[SowParity_remove]([SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowParity_EffectiveDate]
    ON [dbo].[SowParity_remove]([EffectiveDate] ASC) WITH (FILLFACTOR = 80);

