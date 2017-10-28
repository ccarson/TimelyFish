CREATE TABLE [dbo].[EDSNote] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [dtRevisedDate] SMALLDATETIME NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [nID]           INT           NOT NULL,
    [sLevelName]    CHAR (20)     NOT NULL,
    [sNoteText]     TEXT          NOT NULL,
    [sTableName]    CHAR (20)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EDSNote0] PRIMARY KEY CLUSTERED ([nID] ASC) WITH (FILLFACTOR = 90)
);

