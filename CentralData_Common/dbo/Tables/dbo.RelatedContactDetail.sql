CREATE TABLE [dbo].[RelatedContactDetail] (
    [RelatedContactDetailID]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RelatedContactID]                 INT          NOT NULL,
    [RelatedContactRelationshipTypeID] INT          NOT NULL,
    [Comments]                         VARCHAR (50) NULL,
    [AccountNbr]                       VARCHAR (25) NULL,
    CONSTRAINT [PK_RelatedContactDetailID] PRIMARY KEY CLUSTERED ([RelatedContactDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_RelatedContactDetail_RelatedContact] FOREIGN KEY ([RelatedContactID]) REFERENCES [dbo].[RelatedContact] ([RelatedContactID]) ON DELETE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Contact/Type]
    ON [dbo].[RelatedContactDetail]([RelatedContactID] ASC, [RelatedContactRelationshipTypeID] ASC) WITH (FILLFACTOR = 90);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RelatedContactDetail] TO [hybridconnectionlogin_permissions]
    AS [dbo];

