CREATE TABLE [dbo].[DayDefinitionTemp] (
    [WeekOfDate]  SMALLDATETIME NOT NULL,
    [WeekEndDate] SMALLDATETIME NOT NULL,
    [DayDate]     SMALLDATETIME NOT NULL,
    [DayName]     VARCHAR (9)   NULL,
    CONSTRAINT [PK_DayDefinitionTemp] PRIMARY KEY CLUSTERED ([DayDate] ASC) WITH (FILLFACTOR = 80)
);

