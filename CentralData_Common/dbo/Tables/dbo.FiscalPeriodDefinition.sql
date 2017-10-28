CREATE TABLE [dbo].[FiscalPeriodDefinition] (
    [FiscalYear]   SMALLINT      NOT NULL,
    [FiscalPeriod] SMALLINT      NOT NULL,
    [BeginDate]    SMALLDATETIME NULL,
    [EndDate]      SMALLDATETIME NULL,
    CONSTRAINT [PK_FiscalPeriodDefinition] PRIMARY KEY CLUSTERED ([FiscalYear] ASC, [FiscalPeriod] ASC) WITH (FILLFACTOR = 90)
);

