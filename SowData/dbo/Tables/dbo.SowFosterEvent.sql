CREATE TABLE [dbo].[SowFosterEvent] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [Qty]         FLOAT (53)    NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowFosterEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowFosterEvent_FarmID]
    ON [dbo].[SowFosterEvent]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFosterEvent_SowID]
    ON [dbo].[SowFosterEvent]([SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFosterEvent_WeekOfDate]
    ON [dbo].[SowFosterEvent]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFosterEvent_SowParity]
    ON [dbo].[SowFosterEvent]([SowParity] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFosterEvent_SowGenetics]
    ON [dbo].[SowFosterEvent]([SowGenetics] ASC) WITH (FILLFACTOR = 90);

