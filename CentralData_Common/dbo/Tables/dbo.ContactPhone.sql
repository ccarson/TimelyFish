CREATE TABLE [dbo].[ContactPhone] (
    [ContactID]      INT          NOT NULL,
    [PhoneID]        INT          NOT NULL,
    [PhoneTypeID]    INT          NOT NULL,
    [Comment]        VARCHAR (50) NULL,
    [PhoneCarrierID] INT          NULL,
    CONSTRAINT [PK_ContactPhone] PRIMARY KEY CLUSTERED ([ContactID] ASC, [PhoneID] ASC, [PhoneTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ContactPhone_cft_CONTACT_CELL_PHONE_PROVIDER] FOREIGN KEY ([PhoneCarrierID]) REFERENCES [dbo].[cft_CONTACT_CELL_PHONE_PROVIDER] ([CarrierID]),
    CONSTRAINT [FK_ContactPhone_Contact] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE,
    CONSTRAINT [FK_ContactPhone_Phone] FOREIGN KEY ([PhoneID]) REFERENCES [dbo].[Phone] ([PhoneID]) ON DELETE CASCADE
);

GO
GRANT SELECT
    ON OBJECT::[dbo].[ContactPhone] TO [hybridconnectionlogin_permissions]
    AS [dbo];
