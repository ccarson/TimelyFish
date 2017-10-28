CREATE TABLE [dbo].[SowPigletDeathEventTemp] (
    [EventID]     BIGINT        NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [Qty]         FLOAT (53)    NOT NULL,
    [Reason]      VARCHAR (20)  NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowPigletDeathEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEventTemp_FarmIDSowID]
    ON [dbo].[SowPigletDeathEventTemp]([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPigletDeathEventTemp_WeekOfDate]
    ON [dbo].[SowPigletDeathEventTemp]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);

