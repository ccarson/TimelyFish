CREATE TABLE [dbo].[ManureStorageType] (
    [ManureStorageTypeID]    INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [StorageTypeDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureStorageType] PRIMARY KEY CLUSTERED ([ManureStorageTypeID] ASC) WITH (FILLFACTOR = 90)
);

