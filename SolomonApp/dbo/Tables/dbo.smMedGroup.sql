CREATE TABLE [dbo].[smMedGroup] (
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Lupd_DateTime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [MediaGroupDesc] CHAR (30)     NOT NULL,
    [MediaGroupId]   CHAR (10)     NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [smMedGroup0] PRIMARY KEY CLUSTERED ([MediaGroupId] ASC) WITH (FILLFACTOR = 90)
);

