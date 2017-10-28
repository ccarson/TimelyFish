CREATE TABLE [dbo].[cftPigAcct] (
    [acct]          CHAR (16)     NOT NULL,
    [acctCode]      CHAR (2)      NOT NULL,
    [affectEntity]  CHAR (1)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [InvEffect]     SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [cftPigAcct0] PRIMARY KEY CLUSTERED ([acct] ASC) WITH (FILLFACTOR = 90)
);

