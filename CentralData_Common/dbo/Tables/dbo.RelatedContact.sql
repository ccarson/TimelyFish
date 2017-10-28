CREATE TABLE [dbo].[RelatedContact] (
    [RelatedContactID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RelatedID]        INT           NOT NULL,
    [ContactID]        INT           NOT NULL,
    [SummaryOfDetail]  VARCHAR (200) NULL,
    CONSTRAINT [PK_RelatedContact] PRIMARY KEY CLUSTERED ([RelatedContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_RelatedContacts_Contact] FOREIGN KEY ([RelatedID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Related/ContactID]
    ON [dbo].[RelatedContact]([RelatedID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90);

GO
GRANT SELECT
    ON OBJECT::[dbo].[RelatedContact] TO [hybridconnectionlogin_permissions]
    AS [dbo];

