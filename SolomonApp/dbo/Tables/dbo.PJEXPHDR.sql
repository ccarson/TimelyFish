CREATE TABLE [dbo].[PJEXPHDR] (
    [advance_amt]   FLOAT (53)    NOT NULL,
    [approver]      CHAR (10)     NOT NULL,
    [BaseCuryId]    CHAR (4)      NOT NULL,
    [CpnyId_home]   CHAR (10)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [CuryEffDate]   SMALLDATETIME NOT NULL,
    [CuryId]        CHAR (4)      NOT NULL,
    [CuryMultDiv]   CHAR (1)      NOT NULL,
    [CuryRate]      FLOAT (53)    NOT NULL,
    [CuryRateType]  CHAR (6)      NOT NULL,
    [desc_hdr]      CHAR (40)     NOT NULL,
    [docnbr]        CHAR (10)     NOT NULL,
    [employee]      CHAR (10)     NOT NULL,
    [fiscalno]      CHAR (6)      NOT NULL,
    [gl_subacct]    CHAR (24)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [NoteId]        INT           NOT NULL,
    [report_date]   SMALLDATETIME NOT NULL,
    [status_1]      CHAR (1)      NOT NULL,
    [status_2]      CHAR (1)      NOT NULL,
    [te_id01]       CHAR (30)     NOT NULL,
    [te_id02]       CHAR (30)     NOT NULL,
    [te_id03]       CHAR (16)     NOT NULL,
    [te_id04]       CHAR (16)     NOT NULL,
    [te_id05]       CHAR (4)      NOT NULL,
    [te_id06]       FLOAT (53)    NOT NULL,
    [te_id07]       FLOAT (53)    NOT NULL,
    [te_id08]       SMALLDATETIME NOT NULL,
    [te_id09]       SMALLDATETIME NOT NULL,
    [te_id10]       INT           NOT NULL,
    [te_id11]       CHAR (30)     NOT NULL,
    [te_id12]       CHAR (20)     NOT NULL,
    [te_id13]       CHAR (10)     NOT NULL,
    [te_id14]       CHAR (4)      NOT NULL,
    [te_id15]       FLOAT (53)    NOT NULL,
    [tripnbr]       CHAR (10)     NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjexphdr0] PRIMARY KEY CLUSTERED ([docnbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjexphdr1]
    ON [dbo].[PJEXPHDR]([approver] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjexphdr2]
    ON [dbo].[PJEXPHDR]([gl_subacct] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjexphdr3]
    ON [dbo].[PJEXPHDR]([status_1] ASC, [fiscalno] ASC) WITH (FILLFACTOR = 90);

