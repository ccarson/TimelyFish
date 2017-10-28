CREATE TABLE [dbo].[SowMatingEventTemp] (
    [EventID]     BIGINT        NOT NULL,
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
    CONSTRAINT [PK_SowMatingEventTempID] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowMatingEventFarm]
    ON [dbo].[SowMatingEventTemp]([FarmID] ASC, [MatingType] ASC) WITH (FILLFACTOR = 90);

