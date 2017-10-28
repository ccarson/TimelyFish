CREATE TABLE [dbo].[PJINDSRC] (
    [alloc_method_cd] CHAR (4)      NOT NULL,
    [amount_01]       FLOAT (53)    NOT NULL,
    [amount_02]       FLOAT (53)    NOT NULL,
    [amount_03]       FLOAT (53)    NOT NULL,
    [amount_04]       FLOAT (53)    NOT NULL,
    [amount_05]       FLOAT (53)    NOT NULL,
    [amount_06]       FLOAT (53)    NOT NULL,
    [amount_07]       FLOAT (53)    NOT NULL,
    [amount_08]       FLOAT (53)    NOT NULL,
    [amount_09]       FLOAT (53)    NOT NULL,
    [amount_10]       FLOAT (53)    NOT NULL,
    [amount_11]       FLOAT (53)    NOT NULL,
    [amount_12]       FLOAT (53)    NOT NULL,
    [amount_13]       FLOAT (53)    NOT NULL,
    [amount_14]       FLOAT (53)    NOT NULL,
    [amount_15]       FLOAT (53)    NOT NULL,
    [crtd_datetime]   SMALLDATETIME NOT NULL,
    [crtd_prog]       CHAR (8)      NOT NULL,
    [crtd_user]       CHAR (10)     NOT NULL,
    [emp_CpnyId]      CHAR (10)     NOT NULL,
    [emp_gl_subacct]  CHAR (24)     NOT NULL,
    [fsyear_num]      CHAR (4)      NOT NULL,
    [lupd_datetime]   SMALLDATETIME NOT NULL,
    [lupd_prog]       CHAR (8)      NOT NULL,
    [lupd_user]       CHAR (10)     NOT NULL,
    [pjt_entity]      CHAR (32)     NOT NULL,
    [project]         CHAR (16)     NOT NULL,
    [src_acct]        CHAR (16)     NOT NULL,
    [src_CpnyId]      CHAR (10)     NOT NULL,
    [src_gl_subacct]  CHAR (24)     NOT NULL,
    [step_number]     SMALLINT      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [pjindsrc0] PRIMARY KEY CLUSTERED ([fsyear_num] ASC, [project] ASC, [pjt_entity] ASC, [src_acct] ASC, [alloc_method_cd] ASC, [step_number] ASC, [src_CpnyId] ASC, [src_gl_subacct] ASC, [emp_CpnyId] ASC, [emp_gl_subacct] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjindsrc1]
    ON [dbo].[PJINDSRC]([project] ASC, [pjt_entity] ASC, [alloc_method_cd] ASC, [step_number] ASC, [src_acct] ASC, [fsyear_num] ASC) WITH (FILLFACTOR = 90);

