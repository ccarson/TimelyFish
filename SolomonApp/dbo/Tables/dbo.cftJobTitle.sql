CREATE TABLE [dbo].[cftJobTitle] (
    [Description]   CHAR (30)  NOT NULL,
    [DfltAllowance] FLOAT (53) NOT NULL,
    [JobTitle]      CHAR (20)  NOT NULL,
    [NoteID]        INT        NOT NULL,
    [TrackClothing] SMALLINT   NOT NULL,
    [tstamp]        ROWVERSION NOT NULL
);

