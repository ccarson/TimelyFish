CREATE TABLE [dbo].[SowLocationEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [Barn]        VARCHAR (10)  NULL,
    [Room]        VARCHAR (10)  NULL,
    [Crate]       VARCHAR (10)  NULL,
    [EventDate]   SMALLDATETIME NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowLocationEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_sowlocationevent_FarmSowEvnt]
    ON [dbo].[SowLocationEvent_remove]([FarmID] ASC, [SowID] ASC, [EventDate] ASC) WITH (FILLFACTOR = 80);

