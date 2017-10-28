CREATE TABLE [dbo].[cftNoteSubject] (
    [Crtd_Datetime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [NoteSubject]   CHAR (40)     NOT NULL,
    [LUpd_Datetime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftNoteSubject0] PRIMARY KEY CLUSTERED ([NoteSubject] ASC) WITH (FILLFACTOR = 90)
);

