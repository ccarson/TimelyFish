CREATE TABLE [dbo].[cft_DRIVER_DAY_OFF] (
    [DriverDayOffID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DriverID]        INT          NOT NULL,
    [DayOff]          DATETIME     NOT NULL,
    [DayOffType]      VARCHAR (50) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_DRIVER_DAY_OFF_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_DRIVER_DAY_OFF] PRIMARY KEY CLUSTERED ([DriverDayOffID] ASC) WITH (FILLFACTOR = 90)
);

