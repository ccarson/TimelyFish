CREATE TABLE [dbo].[ContactAddress] (
    [ContactID]     INT NOT NULL,
    [AddressID]     INT NOT NULL,
    [AddressTypeID] INT NOT NULL,
    CONSTRAINT [PK_ContactAddress] PRIMARY KEY CLUSTERED ([ContactID] ASC, [AddressID] ASC, [AddressTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ContactAddress_Address] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Address] ([AddressID]) ON DELETE CASCADE,
    CONSTRAINT [FK_ContactAddress_Contact] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE
);

GO
GRANT SELECT
    ON OBJECT::[dbo].[ContactAddress] TO [hybridconnectionlogin_permissions]
    AS [dbo];
