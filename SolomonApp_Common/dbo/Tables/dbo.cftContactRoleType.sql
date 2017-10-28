CREATE TABLE [dbo].[cftContactRoleType] (
    [ContactID]     CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [RoleTypeID]    CHAR (3)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftContactRoleType0] PRIMARY KEY CLUSTERED ([ContactID] ASC, [RoleTypeID] ASC) WITH (FILLFACTOR = 90)
);

