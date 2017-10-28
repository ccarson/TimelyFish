CREATE TABLE [dbo].[PJTEXT] (
    [category_cd]   CHAR (2)      NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [flag1]         CHAR (1)      NOT NULL,
    [flag2]         CHAR (1)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [msg_num]       CHAR (4)      NOT NULL,
    [msg_text]      CHAR (255)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjtext0] PRIMARY KEY CLUSTERED ([msg_num] ASC) WITH (FILLFACTOR = 90)
);

