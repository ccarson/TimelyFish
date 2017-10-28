CREATE TABLE [dbo].[ssNotes] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [PrimaryKey]    CHAR (30)     NOT NULL,
    [ScreenID]      CHAR (7)      NOT NULL,
    [zzNotes]       IMAGE         NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [ssNotes0] PRIMARY KEY CLUSTERED ([ScreenID] ASC, [PrimaryKey] ASC) WITH (FILLFACTOR = 90)
);

