CREATE TABLE [dbo].[AppSecurityRole] (
    [AppSecurityRoleID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AppID]                      INT          NOT NULL,
    [AppSecurityRoleDescription] VARCHAR (50) NULL,
    CONSTRAINT [PK_AppSecurityRole] PRIMARY KEY CLUSTERED ([AppSecurityRoleID] ASC, [AppID] ASC) WITH (FILLFACTOR = 90)
);

