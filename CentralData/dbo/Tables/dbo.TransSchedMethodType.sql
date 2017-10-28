CREATE TABLE [dbo].[TransSchedMethodType] (
    [TransSchedMethodTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TransSchedMethodTypeDescription] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_TransSchedMethodType] PRIMARY KEY CLUSTERED ([TransSchedMethodTypeID] ASC) WITH (FILLFACTOR = 90)
);

