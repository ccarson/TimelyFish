CREATE TABLE [dbo].[cftDayDefinition_WithWeekInfo] (
    [DayDate]      DATETIME    NOT NULL,
    [DayName]      VARCHAR (9) NOT NULL,
    [PICCycle]     CHAR (2)    NOT NULL,
    [PICDayNbr]    CHAR (3)    NOT NULL,
    [WeekOfDate]   DATETIME    NOT NULL,
    [FiscalPeriod] SMALLINT    NOT NULL,
    [FiscalYear]   SMALLINT    NOT NULL,
    [PICWeek]      SMALLINT    NOT NULL,
    [PICYear]      SMALLINT    NOT NULL,
    [PICYear_Week] CHAR (6)    NULL,
    [WeekEndDate]  DATETIME    NOT NULL,
    [PICQuarter]   VARCHAR (7) NULL,
    [FYPeriod]     CHAR (7)    NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [idx_cftDayDefinition_Withweekinfo]
    ON [dbo].[cftDayDefinition_WithWeekInfo]([DayDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftDayDefinition_WithWeekInfo_wod_pic_dd]
    ON [dbo].[cftDayDefinition_WithWeekInfo]([WeekOfDate] ASC, [PICYear_Week] ASC, [DayDate] ASC) WITH (FILLFACTOR = 90);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cftDayDefinition_WithWeekInfo] TO PUBLIC
    AS [dbo];

