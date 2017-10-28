CREATE TABLE [dbo].[SowGroupEventTemp] (
    [EventID]     BIGINT        NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [GroupID]     VARCHAR (8)   NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowGroupEventTempID] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEventTemp_FarmIDSowID]
    ON [dbo].[SowGroupEventTemp]([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEventTemp_EventDate]
    ON [dbo].[SowGroupEventTemp]([EventDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowGroupEventTemp_SowParity]
    ON [dbo].[SowGroupEventTemp]([SowParity] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IdxSowTempFarmID]
    ON [dbo].[SowGroupEventTemp]([FarmID] ASC) WITH (FILLFACTOR = 90);

