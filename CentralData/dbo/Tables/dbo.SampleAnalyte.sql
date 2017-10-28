CREATE TABLE [dbo].[SampleAnalyte] (
    [SampleAnalyteID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]      VARCHAR (30) NULL,
    [ConversionFactor] INT          NULL,
    CONSTRAINT [PK_SampleAnalyte] PRIMARY KEY CLUSTERED ([SampleAnalyteID] ASC) WITH (FILLFACTOR = 90)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to convert for Nutient value - pounds per 1000 gallons', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SampleAnalyte', @level2type = N'COLUMN', @level2name = N'ConversionFactor';

