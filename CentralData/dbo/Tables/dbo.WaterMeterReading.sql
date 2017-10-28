CREATE TABLE [dbo].[WaterMeterReading] (
    [WaterMeterReadingID]  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DateRead]             SMALLDATETIME NOT NULL,
    [Week]                 INT           NOT NULL,
    [SiteContactID]        INT           NOT NULL,
    [WaterMeterID]         INT           NOT NULL,
    [EmployeeContactID]    INT           NULL,
    [ReadingValue]         FLOAT (53)    NULL,
    [Consumption]          FLOAT (53)    NULL,
    [DaysSinceLastReading] INT           NULL,
    [Inventory]            INT           NULL,
    [Comment]              VARCHAR (60)  NULL,
    [MeterTurnover]        SMALLINT      CONSTRAINT [DF_WaterMeterReading_MeterTurnover] DEFAULT (0) NULL,
    CONSTRAINT [PK_WaterMeterReading] PRIMARY KEY CLUSTERED ([DateRead] ASC, [WaterMeterID] ASC) WITH (FILLFACTOR = 90)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'not standard calendar week - PIC week', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WaterMeterReading', @level2type = N'COLUMN', @level2name = N'Week';

