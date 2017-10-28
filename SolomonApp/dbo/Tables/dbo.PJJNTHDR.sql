CREATE TABLE [dbo].[PJJNTHDR] (
    [check_name]    CHAR (80)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [jh_id01]       CHAR (30)     NOT NULL,
    [jh_id02]       CHAR (16)     NOT NULL,
    [jh_id03]       CHAR (4)      NOT NULL,
    [jh_id04]       FLOAT (53)    NOT NULL,
    [jh_id05]       SMALLDATETIME NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [project]       CHAR (16)     NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [vendid]        CHAR (15)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjjnthdr0] PRIMARY KEY CLUSTERED ([vendid] ASC, [project] ASC) WITH (FILLFACTOR = 90)
);

