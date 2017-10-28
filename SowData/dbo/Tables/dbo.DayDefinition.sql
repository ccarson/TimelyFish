CREATE TABLE [dbo].[DayDefinition] (
    [WeekOfDate]  SMALLDATETIME NOT NULL,
    [WeekEndDate] AS            ([WeekOfDate] + 6),
    [DayDate]     SMALLDATETIME NOT NULL,
    [DayName]     VARCHAR (9)   NULL,
    CONSTRAINT [PK_DayDefinition] PRIMARY KEY CLUSTERED ([DayDate] ASC) WITH (FILLFACTOR = 90)
);

