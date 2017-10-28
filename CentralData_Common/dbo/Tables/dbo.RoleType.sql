CREATE TABLE [dbo].[RoleType] (
    [RoleTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RoleTypeDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_SubType] PRIMARY KEY CLUSTERED ([RoleTypeID] ASC) WITH (FILLFACTOR = 90)
);

GO

GRANT SELECT
    ON OBJECT::[dbo].[RoleType] TO [hybridconnectionlogin_permissions]
    AS [dbo];
