CREATE TABLE [dbo].[Building] (
    [BuildingID]              INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]               INT          NOT NULL,
    [BuildingDescription]     VARCHAR (30) NOT NULL,
    [BuildingTypeID]          INT          NULL,
    [BuildingStyleID]         INT          NULL,
    [LossValue]               INT          NULL,
    [ManuverableWithSemiFlag] SMALLINT     CONSTRAINT [DF_Structure_ManuverableWithSemiFlag] DEFAULT (0) NULL,
    [LoadChuteFlag]           SMALLINT     CONSTRAINT [DF_Structure_LoadChuteFlag] DEFAULT (0) NULL,
    [SquareFootage]           FLOAT (53)   NULL,
    [Manufacturer]            VARCHAR (30) NULL,
    [YearBuilt]               INT          NULL,
    [Width]                   FLOAT (53)   NULL,
    [Length]                  FLOAT (53)   NULL,
    [Height]                  FLOAT (53)   NULL,
    [TempBarnID]              INT          NULL,
    CONSTRAINT [PK_Structure] PRIMARY KEY CLUSTERED ([ContactID] ASC, [BuildingDescription] ASC) WITH (FILLFACTOR = 90)
);

