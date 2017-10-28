CREATE TABLE [dbo].[EssbaseUploadPigFLowTemp] (
    [FarmID]       VARCHAR (12)  NULL,
    [WeekOfDate]   SMALLDATETIME NULL,
    [Genetics]     CHAR (20)     NULL,
    [Parity]       SMALLINT      NULL,
    [PICWeek]      SMALLINT      NULL,
    [PICYear]      SMALLINT      NULL,
    [FiscalPeriod] SMALLINT      NULL,
    [FiscalYear]   SMALLINT      NULL,
    [Account]      VARCHAR (30)  NULL,
    [PigFlow]      VARCHAR (100) NULL
);

