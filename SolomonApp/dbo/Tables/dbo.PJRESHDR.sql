﻿CREATE TABLE [dbo].[PJRESHDR] (
    [acct]          CHAR (16)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [pjt_entity]    CHAR (32)     NOT NULL,
    [project]       CHAR (16)     NOT NULL,
    [sh_id01]       CHAR (30)     NOT NULL,
    [sh_id02]       CHAR (30)     NOT NULL,
    [sh_id03]       CHAR (16)     NOT NULL,
    [sh_id04]       CHAR (16)     NOT NULL,
    [sh_id05]       CHAR (4)      NOT NULL,
    [sh_id06]       FLOAT (53)    NOT NULL,
    [sh_id07]       FLOAT (53)    NOT NULL,
    [sh_id08]       SMALLDATETIME NOT NULL,
    [sh_id09]       SMALLDATETIME NOT NULL,
    [sh_id10]       SMALLINT      NOT NULL,
    [sh_id11]       FLOAT (53)    NOT NULL,
    [sh_id12]       FLOAT (53)    NOT NULL,
    [sh_id13]       FLOAT (53)    NOT NULL,
    [sh_id14]       FLOAT (53)    NOT NULL,
    [sh_id15]       FLOAT (53)    NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjreshdr0] PRIMARY KEY CLUSTERED ([project] ASC, [pjt_entity] ASC, [acct] ASC) WITH (FILLFACTOR = 90)
);

