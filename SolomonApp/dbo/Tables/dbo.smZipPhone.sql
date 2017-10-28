CREATE TABLE [dbo].[smZipPhone] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [user1]           CHAR (30)     NOT NULL,
    [user2]           CHAR (30)     NOT NULL,
    [user3]           FLOAT (53)    NOT NULL,
    [user4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [ZipId]           CHAR (10)     NOT NULL,
    [ZipPhoneContact] CHAR (20)     NOT NULL,
    [ZipPhoneNumber]  CHAR (16)     NOT NULL,
    [ZipPhoneType]    CHAR (20)     NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [smZipPhone0] PRIMARY KEY CLUSTERED ([ZipId] ASC, [ZipPhoneType] ASC) WITH (FILLFACTOR = 90)
);

