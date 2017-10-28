CREATE TABLE [dbo].[ScheduleType] (
    [ScheduleTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]    VARCHAR (20) NULL,
    CONSTRAINT [PK_ScheduleType] PRIMARY KEY CLUSTERED ([ScheduleTypeID] ASC) WITH (FILLFACTOR = 90)
);

