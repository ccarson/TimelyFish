CREATE TABLE [dbo].[PJSECURE] (
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [key_value]     CHAR (64)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [password]      CHAR (255)    NOT NULL,
    [pw_type_cd]    CHAR (4)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjsecure0] PRIMARY KEY CLUSTERED ([pw_type_cd] ASC, [key_value] ASC) WITH (FILLFACTOR = 90)
);

