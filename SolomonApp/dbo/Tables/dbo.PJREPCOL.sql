CREATE TABLE [dbo].[PJREPCOL] (
    [acct]          CHAR (16)     NOT NULL,
    [column_nbr]    SMALLINT      NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [desc1]         CHAR (20)     NOT NULL,
    [desc2]         CHAR (20)     NOT NULL,
    [gl_acct]       CHAR (10)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [report_code]   CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjrepcol0] PRIMARY KEY CLUSTERED ([report_code] ASC, [column_nbr] ASC, [acct] ASC, [gl_acct] ASC) WITH (FILLFACTOR = 90)
);

