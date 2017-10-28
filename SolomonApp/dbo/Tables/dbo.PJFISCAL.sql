CREATE TABLE [dbo].[PJFISCAL] (
    [comment]       CHAR (30)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [data1]         CHAR (30)     NOT NULL,
    [end_date]      SMALLDATETIME NOT NULL,
    [factor]        FLOAT (53)    NOT NULL,
    [fiscalno]      CHAR (6)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [start_date]    SMALLDATETIME NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjfiscal0] PRIMARY KEY CLUSTERED ([fiscalno] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjfiscal1]
    ON [dbo].[PJFISCAL]([end_date] ASC) WITH (FILLFACTOR = 90);

