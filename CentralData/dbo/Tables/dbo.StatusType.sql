CREATE TABLE [dbo].[StatusType] (
    [StatusTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [StatusTypeDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_StatusType] PRIMARY KEY CLUSTERED ([StatusTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [StatusDescription]
    ON [dbo].[StatusType]([StatusTypeDescription] ASC) WITH (FILLFACTOR = 90);


GO
GRANT SELECT
    ON OBJECT::[dbo].[StatusType] TO [hybridconnectionlogin_permissions]
    AS [dbo];

