CREATE TABLE [dbo].[ContactRoleType] (
    [ContactID]  INT NOT NULL,
    [RoleTypeID] INT NOT NULL,
    CONSTRAINT [PK_ContactSubType] PRIMARY KEY CLUSTERED ([ContactID] ASC, [RoleTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ContactRoleType_Contact] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE
);

GO
GRANT INSERT
    ON OBJECT::[dbo].[ContactRoleType] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ContactRoleType] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ContactRoleType] TO [hybridconnectionlogin_permissions]
    AS [dbo];
