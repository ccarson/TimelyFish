CREATE TABLE [dbo].[BuildingType] (
    [BuildingTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BuildingTypeDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_StructureType] PRIMARY KEY CLUSTERED ([BuildingTypeID] ASC) WITH (FILLFACTOR = 90)
);

