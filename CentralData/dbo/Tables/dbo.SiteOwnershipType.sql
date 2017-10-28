CREATE TABLE [dbo].[SiteOwnershipType] (
    [SiteOwnershipTypeID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteOwnershipDescription] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_OwnershipType] PRIMARY KEY CLUSTERED ([SiteOwnershipTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[SiteOwnershipType] TO [hybridconnectionlogin_permissions]
    AS [dbo];

