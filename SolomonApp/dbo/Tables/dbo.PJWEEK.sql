CREATE TABLE [dbo].[PJWEEK] (
    [comment]       CHAR (30)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [fiscalno]      CHAR (6)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [period_num]    CHAR (6)      NOT NULL,
    [week_num]      CHAR (2)      NOT NULL,
    [we_date]       SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjweek0] PRIMARY KEY NONCLUSTERED ([we_date] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE CLUSTERED INDEX [pjweek1]
    ON [dbo].[PJWEEK]([period_num] ASC, [week_num] ASC) WITH (FILLFACTOR = 90);

