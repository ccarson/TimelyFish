CREATE TABLE [dbo].[BuildingStyle] (
    [BuildingStyleID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BuildingStyleDescription] VARCHAR (30) NULL,
    [DefaultLossValue]         FLOAT (53)   NULL,
    CONSTRAINT [PK_StructureStyle] PRIMARY KEY CLUSTERED ([BuildingStyleID] ASC) WITH (FILLFACTOR = 90)
);

