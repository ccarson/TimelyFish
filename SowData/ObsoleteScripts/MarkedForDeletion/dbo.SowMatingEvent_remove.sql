CREATE TABLE [dbo].[SowMatingEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NULL,
    [SowID]       VARCHAR (12)  NULL,
    [MatingType]  VARCHAR (10)  NULL,
    [EventDate]   SMALLDATETIME NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SemenID]     VARCHAR (10)  NULL,
    [Observer]    VARCHAR (30)  NULL,
    [HourFlag]    SMALLINT      NULL,
    [MatingNbr]   SMALLINT      NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowMatingEventID] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowMatingEvent_FarmID]
    ON [dbo].[SowMatingEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowMatingEvent_SowID]
    ON [dbo].[SowMatingEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowMatingEvent_WeekOfDate]
    ON [dbo].[SowMatingEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowMatingEvent_SowParity]
    ON [dbo].[SowMatingEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowMatingEvent_SowGenetics]
    ON [dbo].[SowMatingEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);

