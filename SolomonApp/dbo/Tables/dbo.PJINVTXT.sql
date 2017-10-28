CREATE TABLE [dbo].[PJINVTXT] (
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [draft_num]     CHAR (10)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [text_type]     CHAR (1)      NOT NULL,
    [project]       CHAR (16)     NOT NULL,
    [z_text]        TEXT          NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjinvtxt0] PRIMARY KEY CLUSTERED ([draft_num] ASC, [text_type] ASC, [project] ASC) WITH (FILLFACTOR = 90)
);

