CREATE TABLE [dbo].[WeekDefinition_20150113] (
    [WeekOfDate]   SMALLDATETIME NOT NULL,
    [WeekEndDate]  AS            ([WeekOfDate] + 6),
    [PICYear]      SMALLINT      NOT NULL,
    [PICWeek]      SMALLINT      NOT NULL,
    [FiscalYear]   SMALLINT      NULL,
    [FiscalPeriod] SMALLINT      NULL,
    CONSTRAINT [PK_WeekDefinition] PRIMARY KEY CLUSTERED ([WeekOfDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_WeekDefinition_PICYear_PICWeek]
    ON [dbo].[WeekDefinition_20150113]([PICYear] ASC, [PICWeek] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_WeekDefinition_FiscalYear_FiscalPeriod]
    ON [dbo].[WeekDefinition_20150113]([FiscalYear] ASC, [FiscalPeriod] ASC) WITH (FILLFACTOR = 80);

