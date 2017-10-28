CREATE TABLE [dbo].[cftPGInvTType] (
    [acct]          CHAR (16)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Program]  CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [InvEffect]     SMALLINT      NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [TranTypeID]    CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPGInvTType0] PRIMARY KEY CLUSTERED ([TranTypeID] ASC) WITH (FILLFACTOR = 90)
);

