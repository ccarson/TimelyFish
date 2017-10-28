CREATE TABLE [dbo].[ManureLevelReading] (
    [ManureLevelReadingID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]            INT           NOT NULL,
    [ManureStructureID]    INT           NOT NULL,
    [DateRead]             SMALLDATETIME NOT NULL,
    [Week]                 INT           NOT NULL,
    [EmployeeID]           INT           NULL,
    [Comment]              VARCHAR (60)  NULL,
    [DaysSinceLastReading] INT           NULL,
    [LevelChange]          FLOAT (53)    NULL,
    [AvgReading]           FLOAT (53)    NULL,
    [WeeklyLevelChange]    FLOAT (53)    NULL,
    CONSTRAINT [PK_ManureLevelReading] PRIMARY KEY CLUSTERED ([ManureLevelReadingID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Cont/Struc/Date]
    ON [dbo].[ManureLevelReading]([ContactID] ASC, [ManureStructureID] ASC, [DateRead] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_ManureReading_manureLevelReading]
    ON [dbo].[ManureLevelReading]([ManureStructureID] ASC, [DateRead] ASC)
    INCLUDE([ManureLevelReadingID], [ContactID], [LevelChange], [AvgReading]) WITH (FILLFACTOR = 100);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'not standard calendar wee - PIC week', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ManureLevelReading', @level2type = N'COLUMN', @level2name = N'Week';

