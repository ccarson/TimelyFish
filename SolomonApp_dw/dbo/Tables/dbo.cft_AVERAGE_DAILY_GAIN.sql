CREATE TABLE [dbo].[cft_AVERAGE_DAILY_GAIN] (
    [AverageDailyGainID] INT           IDENTITY (1, 1) NOT NULL,
    [Category]           VARCHAR (30)  NULL,
    [LowWeight]          FLOAT (53)    NULL,
    [HighWeight]         FLOAT (53)    NULL,
    [AverageDailyGain]   FLOAT (53)    NULL,
    [EffectiveStartDate] SMALLDATETIME NULL,
    [EffectiveEndDate]   SMALLDATETIME NULL
);

