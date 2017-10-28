CREATE TABLE [dbo].[PigTrailerType] (
    [PigTrailerTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PigTrailerTypeDescription] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_TrailerType] PRIMARY KEY CLUSTERED ([PigTrailerTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Orientation', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType', @level2type = N'COLUMN', @level2name = N'PigTrailerTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType', @level2type = N'COLUMN', @level2name = N'PigTrailerTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType', @level2type = N'COLUMN', @level2name = N'PigTrailerTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType', @level2type = N'COLUMN', @level2name = N'PigTrailerTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType', @level2type = N'COLUMN', @level2name = N'PigTrailerTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PigTrailerType', @level2type = N'COLUMN', @level2name = N'PigTrailerTypeDescription';

