CREATE TABLE [dbo].[PJLABDLY] (
    [certprflag]     SMALLINT      NOT NULL,
    [crtd_datetime]  SMALLDATETIME NOT NULL,
    [crtd_prog]      CHAR (8)      NOT NULL,
    [crtd_user]      CHAR (10)     NOT NULL,
    [data1]          FLOAT (53)    NOT NULL,
    [data2]          FLOAT (53)    NOT NULL,
    [data3]          CHAR (254)    NOT NULL,
    [docnbr]         CHAR (10)     NOT NULL,
    [error]          CHAR (1)      NOT NULL,
    [gl_acct]        CHAR (10)     NOT NULL,
    [gl_subacct]     CHAR (24)     NOT NULL,
    [groupcode]      CHAR (10)     NOT NULL,
    [labor_class_cd] CHAR (4)      NOT NULL,
    [ldl_date]       SMALLDATETIME NOT NULL,
    [ldl_day]        CHAR (4)      NOT NULL,
    [ldl_desc]       CHAR (30)     NOT NULL,
    [ldl_edtime]     CHAR (4)      NOT NULL,
    [ldl_elptime]    CHAR (4)      NOT NULL,
    [ldl_siteid]     CHAR (4)      NOT NULL,
    [ldl_sttime]     CHAR (4)      NOT NULL,
    [ldl_wdhours]    FLOAT (53)    NOT NULL,
    [ly_id01]        CHAR (30)     NOT NULL,
    [ly_id02]        CHAR (30)     NOT NULL,
    [ly_id03]        CHAR (16)     NOT NULL,
    [ly_id04]        CHAR (16)     NOT NULL,
    [ly_id05]        CHAR (4)      NOT NULL,
    [ly_id06]        FLOAT (53)    NOT NULL,
    [ly_id07]        FLOAT (53)    NOT NULL,
    [ly_id08]        SMALLDATETIME NOT NULL,
    [ly_id09]        SMALLDATETIME NOT NULL,
    [ly_id10]        INT           NOT NULL,
    [lineNbr]        SMALLINT      NOT NULL,
    [lupd_datetime]  SMALLDATETIME NOT NULL,
    [lupd_prog]      CHAR (8)      NOT NULL,
    [lupd_user]      CHAR (10)     NOT NULL,
    [NoteId]         INT           NOT NULL,
    [ovt1_wdhours]   FLOAT (53)    NOT NULL,
    [ovt2_wdhours]   FLOAT (53)    NOT NULL,
    [pjt_entity]     CHAR (32)     NOT NULL,
    [project]        CHAR (16)     NOT NULL,
    [user1]          CHAR (30)     NOT NULL,
    [user2]          CHAR (30)     NOT NULL,
    [user3]          FLOAT (53)    NOT NULL,
    [user4]          FLOAT (53)    NOT NULL,
    [WorkType]       CHAR (10)     NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [pjlabdly0] PRIMARY KEY CLUSTERED ([docnbr] ASC, [ldl_siteid] ASC, [lineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjlabdly1]
    ON [dbo].[PJLABDLY]([lineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjlabdly2]
    ON [dbo].[PJLABDLY]([project] ASC, [pjt_entity] ASC, [gl_acct] ASC, [gl_subacct] ASC, [labor_class_cd] ASC, [WorkType] ASC, [certprflag] ASC, [groupcode] ASC) WITH (FILLFACTOR = 90);

