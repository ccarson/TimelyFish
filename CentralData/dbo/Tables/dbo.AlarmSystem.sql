CREATE TABLE [dbo].[AlarmSystem] (
    [AlarmSystemID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AlarmSystemDescription] VARCHAR (15) NOT NULL,
    CONSTRAINT [PK_AlarmSystem] PRIMARY KEY CLUSTERED ([AlarmSystemID] ASC) WITH (FILLFACTOR = 90)
);

