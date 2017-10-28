CREATE TABLE [dbo].[EmissionControlType] (
    [EmissionControlTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EmissionControlTypeDescription] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_EmissionControlType] PRIMARY KEY CLUSTERED ([EmissionControlTypeID] ASC) WITH (FILLFACTOR = 90)
);

