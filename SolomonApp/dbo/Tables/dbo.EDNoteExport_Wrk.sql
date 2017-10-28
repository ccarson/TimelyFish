CREATE TABLE [dbo].[EDNoteExport_Wrk] (
    [ComputerName] CHAR (21)  CONSTRAINT [DF_EDNoteExport_Wrk_ComputerName] DEFAULT (' ') NOT NULL,
    [LineNbr]      INT        CONSTRAINT [DF_EDNoteExport_Wrk_LineNbr] DEFAULT ((0)) NOT NULL,
    [nID]          INT        CONSTRAINT [DF_EDNoteExport_Wrk_nID] DEFAULT ((0)) NOT NULL,
    [NoteText]     CHAR (200) CONSTRAINT [DF_EDNoteExport_Wrk_NoteText] DEFAULT (' ') NOT NULL,
    [tstamp]       ROWVERSION NOT NULL,
    CONSTRAINT [EDNoteExport_Wrk0] PRIMARY KEY CLUSTERED ([ComputerName] ASC, [nID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);

