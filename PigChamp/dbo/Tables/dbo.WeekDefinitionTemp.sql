CREATE TABLE [dbo].[WeekDefinitionTemp] (
    [WeekOfDate]   SMALLDATETIME NOT NULL,
    [WeekEndDate]  SMALLDATETIME NOT NULL,
    [PICYear]      SMALLINT      NOT NULL,
    [PICWeek]      SMALLINT      NOT NULL,
    [FiscalYear]   SMALLINT      NULL,
    [FiscalPeriod] SMALLINT      NULL,
    CONSTRAINT [PK_WeekDefinitionTemp] PRIMARY KEY CLUSTERED ([WeekOfDate] ASC) WITH (FILLFACTOR = 80)
);

