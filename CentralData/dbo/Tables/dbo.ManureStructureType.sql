CREATE TABLE [dbo].[ManureStructureType] (
    [ManureStructTypeID]    INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]           VARCHAR (30) NULL,
    [VolumeCalculationType] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_ManureStructureType] PRIMARY KEY CLUSTERED ([ManureStructTypeID] ASC) WITH (FILLFACTOR = 90)
);

