CREATE TABLE [dbo].[Application] (
    [ApplicationID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ApplicationDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_Application] PRIMARY KEY CLUSTERED ([ApplicationID] ASC) WITH (FILLFACTOR = 90)
);

