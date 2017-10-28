CREATE TABLE [dbo].[PCGroupGeneralEvent] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [GroupID]     VARCHAR (12)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NOT NULL,
    [EventType]   VARCHAR (15)  NOT NULL,
    [CommentType] VARCHAR (10)  NULL,
    [Comment]     VARCHAR (30)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_PCGroupGeneralEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);

