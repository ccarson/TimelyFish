CREATE TABLE [dbo].[BioLevelProtocol] (
    [Department]       VARCHAR (20) NOT NULL,
    [Type]             VARCHAR (20) NOT NULL,
    [BioSecurityLevel] VARCHAR (20) NOT NULL,
    [Protocol]         VARCHAR (20) NOT NULL,
    [Crtd_DateTime]    DATETIME     NOT NULL,
    [Crtd_User]        VARCHAR (50) NOT NULL,
    [Lupd_DateTime]    DATETIME     NULL,
    [Lupd_User]        VARCHAR (50) NULL,
    [SortOrder]        SMALLINT     NULL
);

