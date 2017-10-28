CREATE TABLE [dbo].[SowEvent] (
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL
);


GO
CREATE NONCLUSTERED INDEX [idxSowEvent_FarmID]
    ON [dbo].[SowEvent]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowEvent_SowID]
    ON [dbo].[SowEvent]([SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowEvent_EventDate]
    ON [dbo].[SowEvent]([EventDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowEvent_EventType]
    ON [dbo].[SowEvent]([EventType] ASC) WITH (FILLFACTOR = 90);

