CREATE TABLE [dbo].[cftContactNote] (
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [NID]             CHAR (10)     NOT NULL,
    [NoteSubject]     CHAR (40)     NOT NULL,
    [NoteText1]       CHAR (255)    NOT NULL,
    [NoteText2]       CHAR (255)    NOT NULL,
    [NoteText3]       CHAR (255)    NOT NULL,
    [NoteText4]       CHAR (255)    NOT NULL,
    [PersonContactID] CHAR (6)      NOT NULL,
    [SiteContactID]   CHAR (6)      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [cftContactNote0] PRIMARY KEY CLUSTERED ([NID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxcftContactNote_ContactID]
    ON [dbo].[cftContactNote]([SiteContactID] ASC) WITH (FILLFACTOR = 90);

