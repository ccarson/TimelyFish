CREATE TABLE [dbo].[SowFarrowEvent_remove] (
    [EventID]      BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]       VARCHAR (8)   NOT NULL,
    [SowID]        VARCHAR (12)  NOT NULL,
    [EventDate]    SMALLDATETIME NOT NULL,
    [WeekOfDate]   SMALLDATETIME NULL,
    [QtyBornAlive] FLOAT (53)    NULL,
    [QtyStillBorn] FLOAT (53)    NULL,
    [QtyMummy]     FLOAT (53)    NULL,
    [Induced]      VARCHAR (3)   NULL,
    [Assisted]     VARCHAR (3)   NULL,
    [SowParity]    SMALLINT      NULL,
    [SowGenetics]  VARCHAR (20)  NULL,
    [SortCode]     INT           NULL,
    CONSTRAINT [PK_SowFarrowEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEvent_FarmID]
    ON [dbo].[SowFarrowEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEvent_SowID]
    ON [dbo].[SowFarrowEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEvent_WeekOfDate]
    ON [dbo].[SowFarrowEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEvent_SowParity]
    ON [dbo].[SowFarrowEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEvent_SowGenetics]
    ON [dbo].[SowFarrowEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

