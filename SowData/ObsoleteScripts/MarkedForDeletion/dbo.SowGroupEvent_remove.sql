CREATE TABLE [dbo].[SowGroupEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [GroupID]     VARCHAR (8)   NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowGroupEventID] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEvent_FarmID]
    ON [dbo].[SowGroupEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEvent_SowID]
    ON [dbo].[SowGroupEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEvent_WeekOfDate]
    ON [dbo].[SowGroupEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEvent_SowParity]
    ON [dbo].[SowGroupEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEvent_SowGenetics]
    ON [dbo].[SowGroupEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

