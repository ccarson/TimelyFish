CREATE TABLE [dbo].[RelatedContactRelationshipType] (
    [RelatedContactRelationshipTypeID]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RelatedContactRelationshipDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_RelatedContactRelationshipType] PRIMARY KEY CLUSTERED ([RelatedContactRelationshipTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RelatedContactRelationshipType] TO [hybridconnectionlogin_permissions]
    AS [dbo];

