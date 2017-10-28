CREATE TABLE [dbo].[BarnType] (
    [BarnTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BarnTypeDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_BarnType] PRIMARY KEY CLUSTERED ([BarnTypeID] ASC) WITH (FILLFACTOR = 90)
);

