CREATE TABLE [dbo].[cftOwnershipLevel] (
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Description]      CHAR (30)     NOT NULL,
    [Lupd_DateTime]    CHAR (8)      NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (8)      NOT NULL,
    [OwnershipLevelID] CHAR (2)      NOT NULL,
    [tstamp]           ROWVERSION    NULL
);

