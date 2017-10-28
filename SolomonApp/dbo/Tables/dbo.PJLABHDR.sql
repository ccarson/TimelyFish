CREATE TABLE [dbo].[PJLABHDR] (
    [Approver]      CHAR (10)     NOT NULL,
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
    [docnbr]        CHAR (10)     NOT NULL,
    [employee]      CHAR (10)     NOT NULL,
    [fiscalno]      CHAR (6)      NOT NULL,
    [le_id01]       CHAR (30)     NOT NULL,
    [le_id02]       CHAR (30)     NOT NULL,
    [le_id03]       CHAR (16)     NOT NULL,
    [le_id04]       CHAR (16)     NOT NULL,
    [le_id05]       CHAR (4)      NOT NULL,
    [le_id06]       FLOAT (53)    NOT NULL,
    [le_id07]       FLOAT (53)    NOT NULL,
    [le_id08]       SMALLDATETIME NOT NULL,
    [le_id09]       SMALLDATETIME NOT NULL,
    [le_id10]       INT           NOT NULL,
    [le_key]        CHAR (30)     NOT NULL,
    [le_status]     CHAR (1)      NOT NULL,
    [le_type]       CHAR (2)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [period_num]    CHAR (6)      NOT NULL,
    [pe_date]       SMALLDATETIME NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [week_num]      CHAR (2)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjlabhdr0] PRIMARY KEY CLUSTERED ([docnbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjlabhdr1]
    ON [dbo].[PJLABHDR]([employee] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjlabhdr2]
    ON [dbo].[PJLABHDR]([employee] ASC, [docnbr] ASC, [le_type] ASC, [pe_date] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PJLABHDR3]
    ON [dbo].[PJLABHDR]([employee] ASC, [pe_date] ASC) WITH (FILLFACTOR = 90);

