CREATE TABLE [dbo].[ManureAppDetailSubType] (
    [ManureAppDetailSubTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureAppDetailSubTypeDescription] VARCHAR (10) NULL,
    CONSTRAINT [PK_Table1] PRIMARY KEY CLUSTERED ([ManureAppDetailSubTypeID] ASC) WITH (FILLFACTOR = 90)
);

