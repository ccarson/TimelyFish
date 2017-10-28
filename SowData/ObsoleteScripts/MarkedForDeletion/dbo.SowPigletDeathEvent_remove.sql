CREATE TABLE [dbo].[SowPigletDeathEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [Qty]         FLOAT (53)    NOT NULL,
    [Reason]      VARCHAR (20)  NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowPigletDeathEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEvent_FarmID]
    ON [dbo].[SowPigletDeathEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEvent_SowID]
    ON [dbo].[SowPigletDeathEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEvent_WeekOfDate]
    ON [dbo].[SowPigletDeathEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEvent_SowParity]
    ON [dbo].[SowPigletDeathEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEvent_SowGenetics]
    ON [dbo].[SowPigletDeathEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

