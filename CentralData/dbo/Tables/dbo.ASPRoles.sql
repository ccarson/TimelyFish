CREATE TABLE [dbo].[ASPRoles] (
    [RoleID] INT           NOT NULL,
    [Name]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_asproles] PRIMARY KEY CLUSTERED ([RoleID] ASC) WITH (FILLFACTOR = 90)
);

