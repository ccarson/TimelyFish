CREATE TABLE [dbo].[PJUTPER] (
    [comment]       CHAR (30)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [end_date]      SMALLDATETIME NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [period]        CHAR (6)      NOT NULL,
    [pu_id01]       CHAR (30)     NOT NULL,
    [pu_id02]       CHAR (30)     NOT NULL,
    [pu_id03]       CHAR (20)     NOT NULL,
    [pu_id04]       CHAR (20)     NOT NULL,
    [pu_id05]       CHAR (10)     NOT NULL,
    [pu_id06]       CHAR (10)     NOT NULL,
    [pu_id07]       CHAR (4)      NOT NULL,
    [pu_id08]       FLOAT (53)    NOT NULL,
    [pu_id09]       SMALLDATETIME NOT NULL,
    [pu_id10]       INT           NOT NULL,
    [start_date]    SMALLDATETIME NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjutper0] PRIMARY KEY CLUSTERED ([period] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjutper1]
    ON [dbo].[PJUTPER]([end_date] ASC) WITH (FILLFACTOR = 90);

