CREATE TABLE [dbo].[ManureSystemType] (
    [ManureSystemTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureSystemTypeDescription] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_ManureSystemType] PRIMARY KEY CLUSTERED ([ManureSystemTypeID] ASC) WITH (FILLFACTOR = 90)
);

