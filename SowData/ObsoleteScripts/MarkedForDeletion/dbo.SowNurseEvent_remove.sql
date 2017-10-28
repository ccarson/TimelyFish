CREATE TABLE [dbo].[SowNurseEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [Qty]         FLOAT (53)    NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowNurseEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowNurseEvent_FarmID]
    ON [dbo].[SowNurseEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowNurseEvent_SowID]
    ON [dbo].[SowNurseEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idxSowNurseEvent_WeekOfDate]
    ON [dbo].[SowNurseEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idxSowNurseEvent_SowParity]
    ON [dbo].[SowNurseEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowNurseEvent_SowGenetics]
    ON [dbo].[SowNurseEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

