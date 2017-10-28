CREATE TABLE [dbo].[SowFalloutEventTemp] (
    [EventID]     BIGINT        NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowFalloutEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEventTemp_FarmIDSowID]
    ON [dbo].[SowFalloutEventTemp]([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEventTemp_EventDate]
    ON [dbo].[SowFalloutEventTemp]([EventDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowFalloutEventTemp_SowParity]
    ON [dbo].[SowFalloutEventTemp]([SowParity] ASC) WITH (FILLFACTOR = 90);

