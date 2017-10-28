﻿CREATE TABLE [dbo].[PJJNTDET] (
    [crtd_datetime]   SMALLDATETIME NOT NULL,
    [crtd_prog]       CHAR (8)      NOT NULL,
    [crtd_user]       CHAR (10)     NOT NULL,
    [jd_id01]         CHAR (30)     NOT NULL,
    [jd_id02]         CHAR (16)     NOT NULL,
    [jd_id03]         CHAR (4)      NOT NULL,
    [jd_id04]         FLOAT (53)    NOT NULL,
    [jd_id05]         SMALLDATETIME NOT NULL,
    [linenbr]         SMALLINT      NOT NULL,
    [lupd_datetime]   SMALLDATETIME NOT NULL,
    [lupd_prog]       CHAR (8)      NOT NULL,
    [lupd_user]       CHAR (10)     NOT NULL,
    [notice_comment]  CHAR (30)     NOT NULL,
    [notice_date]     SMALLDATETIME NOT NULL,
    [payee_name]      CHAR (60)     NOT NULL,
    [project]         CHAR (16)     NOT NULL,
    [release_comment] CHAR (30)     NOT NULL,
    [release_date]    SMALLDATETIME NOT NULL,
    [user1]           CHAR (30)     NOT NULL,
    [user2]           CHAR (30)     NOT NULL,
    [user3]           FLOAT (53)    NOT NULL,
    [user4]           FLOAT (53)    NOT NULL,
    [vendid]          CHAR (15)     NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [pjjntdet0] PRIMARY KEY CLUSTERED ([vendid] ASC, [project] ASC, [linenbr] ASC) WITH (FILLFACTOR = 90)
);
