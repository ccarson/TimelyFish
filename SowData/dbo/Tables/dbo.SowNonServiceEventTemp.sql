CREATE TABLE [dbo].[SowNonServiceEventTemp] (
    [EventID]     BIGINT        NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowNonServiceEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);

