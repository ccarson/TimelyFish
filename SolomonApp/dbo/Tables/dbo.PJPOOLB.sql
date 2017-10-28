CREATE TABLE [dbo].[PJPOOLB] (
    [alloc_amount_ptd] FLOAT (53)    NOT NULL,
    [alloc_amount_ytd] FLOAT (53)    NOT NULL,
    [alloc_cpnyid]     CHAR (10)     NOT NULL,
    [alloc_gl_acct]    CHAR (10)     NOT NULL,
    [alloc_gl_subacct] CHAR (24)     NOT NULL,
    [basis_amount_ptd] FLOAT (53)    NOT NULL,
    [basis_amount_ytd] FLOAT (53)    NOT NULL,
    [basis_cpnyid]     CHAR (10)     NOT NULL,
    [basis_factor]     FLOAT (53)    NOT NULL,
    [basis_gl_acct]    CHAR (10)     NOT NULL,
    [basis_gl_subacct] CHAR (24)     NOT NULL,
    [crtd_datetime]    SMALLDATETIME NOT NULL,
    [crtd_prog]        CHAR (8)      NOT NULL,
    [crtd_user]        CHAR (10)     NOT NULL,
    [grpid]            CHAR (6)      NOT NULL,
    [lupd_datetime]    SMALLDATETIME NOT NULL,
    [lupd_prog]        CHAR (8)      NOT NULL,
    [lupd_user]        CHAR (10)     NOT NULL,
    [noteid]           INT           NOT NULL,
    [period]           CHAR (6)      NOT NULL,
    [pb_id01]          CHAR (30)     NOT NULL,
    [pb_id02]          CHAR (16)     NOT NULL,
    [pb_id03]          FLOAT (53)    NOT NULL,
    [pb_id04]          FLOAT (53)    NOT NULL,
    [pb_id05]          SMALLDATETIME NOT NULL,
    [pb_id06]          INT           NOT NULL,
    [recnbr]           INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [user1]            CHAR (30)     NOT NULL,
    [user2]            CHAR (30)     NOT NULL,
    [user3]            FLOAT (53)    NOT NULL,
    [user4]            FLOAT (53)    NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [pjpoolb0] PRIMARY KEY CLUSTERED ([grpid] ASC, [period] ASC, [recnbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PJPOOLB1]
    ON [dbo].[PJPOOLB]([grpid] ASC, [period] ASC, [alloc_cpnyid] ASC, [alloc_gl_acct] ASC, [alloc_gl_subacct] ASC) WITH (FILLFACTOR = 90);

