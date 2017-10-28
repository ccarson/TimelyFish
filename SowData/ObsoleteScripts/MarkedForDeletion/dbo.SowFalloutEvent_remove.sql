CREATE TABLE [dbo].[SowFalloutEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowFalloutEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEvent_FarmID]
    ON [dbo].[SowFalloutEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEvent_SowID]
    ON [dbo].[SowFalloutEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEvent_WeekOfDate]
    ON [dbo].[SowFalloutEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEvent_SowParity]
    ON [dbo].[SowFalloutEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEvent_SowGenetics]
    ON [dbo].[SowFalloutEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

