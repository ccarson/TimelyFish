CREATE TABLE [dbo].[Snote] (
    [dtRevisedDate] SMALLDATETIME NOT NULL,
    [nID]           INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [sLevelName]    CHAR (20)     NOT NULL,
    [sTableName]    CHAR (20)     NOT NULL,
    [sNoteText]     TEXT          NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [SNote0] PRIMARY KEY CLUSTERED ([nID] ASC) WITH (FILLFACTOR = 90)
);

