CREATE TABLE [dbo].[PJLabDis] (
    [acct]           CHAR (16)     NOT NULL,
    [amount]         FLOAT (53)    NOT NULL,
    [BaseCuryId]     CHAR (4)      NOT NULL,
    [CpnyId_chrg]    CHAR (10)     NOT NULL,
    [CpnyId_home]    CHAR (10)     NOT NULL,
    [crtd_datetime]  SMALLDATETIME NOT NULL,
    [crtd_prog]      CHAR (8)      NOT NULL,
    [crtd_user]      CHAR (10)     NOT NULL,
    [CuryEffDate]    SMALLDATETIME NOT NULL,
    [CuryId]         CHAR (4)      NOT NULL,
    [CuryMultDiv]    CHAR (1)      NOT NULL,
    [CuryRate]       FLOAT (53)    NOT NULL,
    [CuryRateType]   CHAR (6)      NOT NULL,
    [CuryTranamt]    FLOAT (53)    NOT NULL,
    [Curystdcost]    FLOAT (53)    NOT NULL,
    [dl_id01]        CHAR (30)     NOT NULL,
    [dl_id02]        CHAR (30)     NOT NULL,
    [dl_id03]        CHAR (16)     NOT NULL,
    [dl_id04]        CHAR (16)     NOT NULL,
    [dl_id05]        CHAR (4)      NOT NULL,
    [dl_id06]        FLOAT (53)    NOT NULL,
    [dl_id07]        FLOAT (53)    NOT NULL,
    [dl_id08]        SMALLDATETIME NOT NULL,
    [dl_id09]        SMALLDATETIME NOT NULL,
    [dl_id10]        INT           NOT NULL,
    [dl_id11]        CHAR (30)     NOT NULL,
    [dl_id12]        CHAR (30)     NOT NULL,
    [dl_id13]        CHAR (20)     NOT NULL,
    [dl_id14]        CHAR (20)     NOT NULL,
    [dl_id15]        CHAR (10)     NOT NULL,
    [dl_id16]        CHAR (10)     NOT NULL,
    [dl_id17]        CHAR (4)      NOT NULL,
    [dl_id18]        FLOAT (53)    NOT NULL,
    [dl_id19]        FLOAT (53)    NOT NULL,
    [dl_id20]        SMALLDATETIME NOT NULL,
    [docnbr]         CHAR (10)     NOT NULL,
    [earn_type_id]   CHAR (10)     NOT NULL,
    [employee]       CHAR (10)     NOT NULL,
    [fiscalno]       CHAR (6)      NOT NULL,
    [gl_acct]        CHAR (10)     NOT NULL,
    [gl_subacct]     CHAR (24)     NOT NULL,
    [home_subacct]   CHAR (24)     NOT NULL,
    [hrs_type]       CHAR (4)      NOT NULL,
    [labor_class_cd] CHAR (4)      NOT NULL,
    [labor_stdcost]  FLOAT (53)    NOT NULL,
    [linenbr]        SMALLINT      NOT NULL,
    [lupd_datetime]  SMALLDATETIME NOT NULL,
    [lupd_prog]      CHAR (8)      NOT NULL,
    [lupd_user]      CHAR (10)     NOT NULL,
    [pe_date]        SMALLDATETIME NOT NULL,
    [pjt_entity]     CHAR (32)     NOT NULL,
    [premium_hrs]    FLOAT (53)    NOT NULL,
    [project]        CHAR (16)     NOT NULL,
    [rate_source]    CHAR (1)      NOT NULL,
    [shift]          CHAR (7)      NOT NULL,
    [status_1]       CHAR (2)      NOT NULL,
    [status_2]       CHAR (2)      NOT NULL,
    [status_gl]      CHAR (2)      NOT NULL,
    [SubTask_Name]   CHAR (50)     NOT NULL,
    [union_cd]       CHAR (10)     NOT NULL,
    [work_comp_cd]   CHAR (6)      NOT NULL,
    [work_type]      CHAR (2)      NOT NULL,
    [worked_hrs]     FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [pjlabdis0] PRIMARY KEY CLUSTERED ([docnbr] ASC, [hrs_type] ASC, [linenbr] ASC, [status_2] ASC, [dl_id08] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [pjlabdis1]
    ON [dbo].[PJLabDis]([employee] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjlabdis2]
    ON [dbo].[PJLabDis]([status_1] ASC, [pe_date] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjlabdis3]
    ON [dbo].[PJLabDis]([fiscalno] ASC, [employee] ASC) WITH (FILLFACTOR = 90);

