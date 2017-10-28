CREATE TABLE [dbo].[ManureAppDetailType] (
    [ManureAppDetailTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureAppDetailTypeDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureAppDetailType] PRIMARY KEY CLUSTERED ([ManureAppDetailTypeID] ASC) WITH (FILLFACTOR = 90)
);

