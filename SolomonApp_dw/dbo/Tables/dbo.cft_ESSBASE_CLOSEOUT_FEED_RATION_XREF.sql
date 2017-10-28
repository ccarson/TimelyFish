CREATE TABLE [dbo].[cft_ESSBASE_CLOSEOUT_FEED_RATION_XREF] (
    [TaskID]          CHAR (10)  NOT NULL,
    [Feed_qty_75]     FLOAT (53) NULL,
    [Feed_qty_55]     FLOAT (53) NULL,
    [Feed_qty_54]     FLOAT (53) NULL,
    [actclosedate]    DATETIME   NOT NULL,
    [FirstUseDate_75] DATETIME   NULL,
    [FirstUseDate_55] DATETIME   NULL,
    [FirstUseDate_54] DATETIME   NULL,
    [DaysOn75]        INT        NULL,
    [DaysOn55]        INT        NULL,
    [DaysOn54]        INT        NULL
);

