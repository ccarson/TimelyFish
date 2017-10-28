CREATE TABLE [dbo].[cftWeekDefinition] (
    [FiscalPeriod] SMALLINT      NOT NULL,
    [FiscalYear]   SMALLINT      NOT NULL,
    [PICWeek]      SMALLINT      NOT NULL,
    [PICYear]      SMALLINT      NOT NULL,
    [WeekEndDate]  SMALLDATETIME NOT NULL,
    [WeekOfDate]   SMALLDATETIME NOT NULL,
    [tstamp]       ROWVERSION    NULL,
    CONSTRAINT [cftWeekDefinition0] PRIMARY KEY CLUSTERED ([WeekEndDate] ASC, [WeekOfDate] ASC) WITH (FILLFACTOR = 90)
);

