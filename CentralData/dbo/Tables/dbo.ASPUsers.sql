CREATE TABLE [dbo].[ASPUsers] (
    [DisplayName] NVARCHAR (50) NULL,
    [Password]    NVARCHAR (50) NULL,
    [UserID]      INT           NOT NULL,
    [UserName]    NVARCHAR (50) NOT NULL,
    [RoleID]      INT           NOT NULL,
    CONSTRAINT [PK_ASPUsers] PRIMARY KEY CLUSTERED ([UserID] ASC, [RoleID] ASC) WITH (FILLFACTOR = 90)
);

