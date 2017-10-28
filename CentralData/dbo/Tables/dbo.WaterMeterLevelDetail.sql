CREATE TABLE [dbo].[WaterMeterLevelDetail] (
    [WaterMeterLevelDetailID] INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [WaterMeterID]            INT NOT NULL,
    [BarnID]                  INT NOT NULL,
    [RoomID]                  INT NULL,
    CONSTRAINT [PK_WaterMeterLevelDetail] PRIMARY KEY CLUSTERED ([WaterMeterLevelDetailID] ASC) WITH (FILLFACTOR = 90)
);

