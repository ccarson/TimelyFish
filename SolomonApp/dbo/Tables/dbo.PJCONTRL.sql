CREATE TABLE [dbo].[PJCONTRL] (
    [control_code]  CHAR (30)     NOT NULL,
    [control_data]  CHAR (255)    NOT NULL,
    [control_desc]  CHAR (30)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [control_type]  CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjcontrl0] PRIMARY KEY CLUSTERED ([control_type] ASC, [control_code] ASC) WITH (FILLFACTOR = 90)
);

