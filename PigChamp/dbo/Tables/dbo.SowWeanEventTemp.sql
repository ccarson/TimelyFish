CREATE TABLE [dbo].[SowWeanEventTemp] (
    [EventID]     BIGINT        NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventType]   VARCHAR (20)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [Qty]         FLOAT (53)    NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    CONSTRAINT [PK_SowWeanEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 80)
);

