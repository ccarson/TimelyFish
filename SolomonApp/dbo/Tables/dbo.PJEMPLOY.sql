CREATE TABLE [dbo].[PJEMPLOY] (
    [BaseCuryId]       CHAR (4)      NOT NULL,
    [CpnyId]           CHAR (10)     NOT NULL,
    [crtd_datetime]    SMALLDATETIME NOT NULL,
    [crtd_prog]        CHAR (8)      NOT NULL,
    [crtd_user]        CHAR (10)     NOT NULL,
    [CuryId]           CHAR (4)      NOT NULL,
    [CuryRateType]     CHAR (6)      NOT NULL,
    [date_hired]       SMALLDATETIME NOT NULL,
    [date_terminated]  SMALLDATETIME NOT NULL,
    [employee]         CHAR (10)     NOT NULL,
    [emp_name]         CHAR (60)     NOT NULL,
    [emp_status]       CHAR (1)      NOT NULL,
    [emp_type_cd]      CHAR (4)      NOT NULL,
    [em_id01]          CHAR (30)     NOT NULL,
    [em_id02]          CHAR (30)     NOT NULL,
    [em_id03]          CHAR (50)     NOT NULL,
    [em_id04]          CHAR (16)     NOT NULL,
    [em_id05]          CHAR (4)      NOT NULL,
    [em_id06]          FLOAT (53)    NOT NULL,
    [em_id07]          FLOAT (53)    NOT NULL,
    [em_id08]          SMALLDATETIME NOT NULL,
    [em_id09]          SMALLDATETIME NOT NULL,
    [em_id10]          INT           NOT NULL,
    [em_id11]          CHAR (30)     NOT NULL,
    [em_id12]          CHAR (30)     NOT NULL,
    [em_id13]          CHAR (20)     NOT NULL,
    [em_id14]          CHAR (20)     NOT NULL,
    [em_id15]          CHAR (10)     NOT NULL,
    [em_id16]          CHAR (10)     NOT NULL,
    [em_id17]          CHAR (4)      NOT NULL,
    [em_id18]          FLOAT (53)    NOT NULL,
    [em_id19]          SMALLDATETIME NOT NULL,
    [em_id20]          INT           NOT NULL,
    [em_id21]          CHAR (10)     NOT NULL,
    [em_id22]          CHAR (10)     NOT NULL,
    [em_id23]          CHAR (10)     NOT NULL,
    [em_id24]          CHAR (10)     NOT NULL,
    [em_id25]          CHAR (10)     NOT NULL,
    [exp_approval_max] FLOAT (53)    NOT NULL,
    [gl_subacct]       CHAR (24)     NOT NULL,
    [lupd_datetime]    SMALLDATETIME NOT NULL,
    [lupd_prog]        CHAR (8)      NOT NULL,
    [lupd_user]        CHAR (10)     NOT NULL,
    [manager1]         CHAR (10)     NOT NULL,
    [manager2]         CHAR (10)     NOT NULL,
    [MSPData]          CHAR (50)     NOT NULL,
    [MSPInterface]     CHAR (1)      NOT NULL,
    [MSPRes_UID]       INT           NOT NULL,
    [MSPType]          CHAR (1)      NOT NULL,
    [noteid]           INT           NOT NULL,
    [placeholder]      CHAR (1)      NOT NULL,
    [projExec]         SMALLINT      NOT NULL,
    [stdday]           SMALLINT      NOT NULL,
    [Stdweek]          SMALLINT      NOT NULL,
    [Subcontractor]    CHAR (1)      NOT NULL,
    [user1]            CHAR (30)     NOT NULL,
    [user2]            CHAR (30)     NOT NULL,
    [user3]            FLOAT (53)    NOT NULL,
    [user4]            FLOAT (53)    NOT NULL,
    [user_id]          CHAR (50)     NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [pjemploy0] PRIMARY KEY CLUSTERED ([employee] ASC)
);


GO
CREATE NONCLUSTERED INDEX [pjemploy1]
    ON [dbo].[PJEMPLOY]([manager1] ASC);


GO
CREATE NONCLUSTERED INDEX [pjemploy2]
    ON [dbo].[PJEMPLOY]([manager2] ASC);


GO
CREATE NONCLUSTERED INDEX [pjemploy3]
    ON [dbo].[PJEMPLOY]([gl_subacct] ASC);


GO
CREATE NONCLUSTERED INDEX [pjemploy4]
    ON [dbo].[PJEMPLOY]([emp_name] ASC);


GO
CREATE NONCLUSTERED INDEX [pjemploy5]
    ON [dbo].[PJEMPLOY]([user_id] ASC);

