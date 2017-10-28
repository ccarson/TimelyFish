CREATE TABLE [dbo].[cftBioLevelProtocol] (
    [BioSecurityLevel] CHAR (20)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_User]        CHAR (50)     NOT NULL,
    [Department]       CHAR (20)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NULL,
    [Lupd_User]        CHAR (50)     NULL,
    [Protocol]         CHAR (20)     NOT NULL,
    [Type]             CHAR (20)     NOT NULL,
    [SortOrder]        SMALLINT      NULL,
    CONSTRAINT [cftBioLevelProtocol0] PRIMARY KEY CLUSTERED ([Department] ASC, [Type] ASC, [BioSecurityLevel] ASC) WITH (FILLFACTOR = 90)
);

