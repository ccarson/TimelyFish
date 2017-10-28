CREATE TABLE [dbo].[TrailerAvailability] (
    [TruckerTrailerID] INT NOT NULL,
    [DayAvailable]     INT NULL,
    CONSTRAINT [PK_TrailerAvailability] PRIMARY KEY CLUSTERED ([TruckerTrailerID] ASC) WITH (FILLFACTOR = 90)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Orientation', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability', @level2type = N'COLUMN', @level2name = N'TruckerTrailerID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability', @level2type = N'COLUMN', @level2name = N'TruckerTrailerID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability', @level2type = N'COLUMN', @level2name = N'TruckerTrailerID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability', @level2type = N'COLUMN', @level2name = N'DayAvailable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability', @level2type = N'COLUMN', @level2name = N'DayAvailable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TrailerAvailability', @level2type = N'COLUMN', @level2name = N'DayAvailable';

