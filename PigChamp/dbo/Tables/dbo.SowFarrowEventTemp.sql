CREATE TABLE [dbo].[SowFarrowEventTemp] (
    [EventID]      BIGINT        NOT NULL,
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
    CONSTRAINT [PK_SowFarrowEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEventTemp_EventDate]
    ON [dbo].[SowFarrowEventTemp]([EventDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEventTemp_FarmIDSowID]
    ON [dbo].[SowFarrowEventTemp]([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEventTemp_SowParity]
    ON [dbo].[SowFarrowEventTemp]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowFarrowEventTemp_WeekOfDate]
    ON [dbo].[SowFarrowEventTemp]([WeekOfDate] ASC) WITH (FILLFACTOR = 80);

