CREATE TABLE [dbo].[cftRoleType] (
    [Crtd_DateTime] SMALLDATETIME NULL,
    [Crtd_Prog]     CHAR (8)      NULL,
    [Crtd_User]     CHAR (10)     NULL,
    [Description]   CHAR (30)     NULL,
    [Lupd_DateTime] SMALLDATETIME NULL,
    [Lupd_Prog]     CHAR (8)      NULL,
    [Lupd_User]     CHAR (10)     NULL,
    [RoleTypeID]    CHAR (3)      NULL,
    [tstamp]        ROWVERSION    NULL
);

