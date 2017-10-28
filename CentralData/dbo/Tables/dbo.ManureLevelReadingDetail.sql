CREATE TABLE [dbo].[ManureLevelReadingDetail] (
    [ManureLevelReadingDetailID] INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureLevelReadingID]       INT        NULL,
    [ReadingValue]               FLOAT (53) NULL,
    CONSTRAINT [PK_ManureLevelReadingDetail] PRIMARY KEY CLUSTERED ([ManureLevelReadingDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ManureLevelReadingDetail_ManureLevelReading] FOREIGN KEY ([ManureLevelReadingID]) REFERENCES [dbo].[ManureLevelReading] ([ManureLevelReadingID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_ManureLevelReadingDetail_manureLevelReadingID]
    ON [dbo].[ManureLevelReadingDetail]([ManureLevelReadingID] ASC)
    INCLUDE([ReadingValue]) WITH (FILLFACTOR = 90);

