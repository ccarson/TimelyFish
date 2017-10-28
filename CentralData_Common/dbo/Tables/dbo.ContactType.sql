CREATE TABLE [dbo].[ContactType] (
    [ContactTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactTypeDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED ([ContactTypeID] ASC) WITH (FILLFACTOR = 90)
);

GO
GRANT SELECT
    ON OBJECT::[dbo].[ContactType] TO [hybridconnectionlogin_permissions]
    AS [dbo];
