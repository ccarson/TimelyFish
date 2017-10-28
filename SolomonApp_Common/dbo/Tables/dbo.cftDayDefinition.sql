CREATE TABLE [dbo].[cftDayDefinition] (
    [DayDate]    SMALLDATETIME NOT NULL,
    [DayName]    VARCHAR (9)   NOT NULL,
    [PICCycle]   CHAR (2)      NOT NULL,
    [PICDayNbr]  CHAR (3)      NOT NULL,
    [WeekOfDate] SMALLDATETIME NOT NULL,
    [tstamp]     ROWVERSION    NULL,
    CONSTRAINT [cftDayDefinition0] PRIMARY KEY CLUSTERED ([DayDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxcftDayDefinition_WeekOfDate]
    ON [dbo].[cftDayDefinition]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);

