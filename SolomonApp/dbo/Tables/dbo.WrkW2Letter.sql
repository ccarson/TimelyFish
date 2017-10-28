CREATE TABLE [dbo].[WrkW2Letter] (
    [Amt]    FLOAT (53) NOT NULL,
    [CpnyID] CHAR (10)  NOT NULL,
    [Descr]  CHAR (50)  NOT NULL,
    [Letter] CHAR (2)   NOT NULL,
    [NoteId] INT        NOT NULL,
    [tstamp] ROWVERSION NOT NULL
);

