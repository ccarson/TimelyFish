CREATE TABLE [dbo].[PJNOTES] (
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [key_index]     CHAR (2)      NOT NULL,
    [key_value]     CHAR (64)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [notes1]        CHAR (254)    NOT NULL,
    [notes2]        CHAR (254)    NOT NULL,
    [notes3]        CHAR (254)    NOT NULL,
    [note_disp]     CHAR (40)     NOT NULL,
    [note_type_cd]  CHAR (4)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjnotes0] PRIMARY KEY CLUSTERED ([note_type_cd] ASC, [key_value] ASC, [key_index] ASC) WITH (FILLFACTOR = 90)
);

