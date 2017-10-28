CREATE TABLE [dbo].[SowNonServiceEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowNonServiceEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idxSowNonServiceEvent_FarmID]
    ON [dbo].[SowNonServiceEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [dxSowNonServiceEvent_SowID]
    ON [dbo].[SowNonServiceEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [dxSowNonServiceEvent_WeekOfDate]
    ON [dbo].[SowNonServiceEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [dxSowNonServiceEvent_SowParity]
    ON [dbo].[SowNonServiceEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [dxSowNonServiceEvent_SowGenetics]
    ON [dbo].[SowNonServiceEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

