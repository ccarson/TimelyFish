CREATE TABLE [dbo].[ContactSecurityRole] (
    [ContactID]         INT NOT NULL,
    [AppSecurityRoleID] INT NOT NULL,
    CONSTRAINT [PK_ContactSecurityRole] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[ContactSecurityRole] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ContactSecurityRole] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ContactSecurityRole] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ContactSecurityRole] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ContactSecurityRole] TO [SE\ITDevelopers]
    AS [dbo];

