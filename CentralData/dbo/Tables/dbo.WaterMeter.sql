CREATE TABLE [dbo].[WaterMeter] (
    [ContactID]       INT          NOT NULL,
    [WaterMeterID]    INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]     VARCHAR (30) NOT NULL,
    [WaterMeterUOM]   INT          NOT NULL,
    [Active]          SMALLINT     CONSTRAINT [DF_WaterMeter_Active] DEFAULT ((-1)) NULL,
    [TurnoverReading] NUMERIC (18) NULL,
    [MeterLevel]      VARCHAR (10) NULL,
    CONSTRAINT [PK_WaterMeter] PRIMARY KEY CLUSTERED ([ContactID] ASC, [WaterMeterID] ASC) WITH (FILLFACTOR = 90)
);

