CREATE TABLE [dbo].[ManureMovementType] (
    [ManurMovementTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]         VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureRemovalType] PRIMARY KEY CLUSTERED ([ManurMovementTypeID] ASC) WITH (FILLFACTOR = 90)
);

