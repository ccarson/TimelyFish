CREATE TABLE [dbo].[SowLocationEventTemp] (
    [EventID]     BIGINT        NOT NULL,
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
    CONSTRAINT [PK_SowLocationEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);

