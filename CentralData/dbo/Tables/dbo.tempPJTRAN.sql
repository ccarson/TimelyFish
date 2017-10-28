CREATE TABLE [dbo].[tempPJTRAN] (
    [acct]            CHAR (16)     NOT NULL,
    [alloc_flag]      CHAR (1)      NULL,
    [amount]          FLOAT (53)    NOT NULL,
    [BaseCuryId]      CHAR (4)      NULL,
    [batch_id]        CHAR (10)     NULL,
    [batch_type]      CHAR (4)      NULL,
    [bill_batch_id]   CHAR (10)     NULL,
    [CpnyId]          CHAR (10)     NULL,
    [crtd_datetime]   SMALLDATETIME NULL,
    [crtd_prog]       CHAR (8)      NULL,
    [crtd_user]       CHAR (10)     NULL,
    [CuryEffDate]     SMALLDATETIME NULL,
    [CuryId]          CHAR (4)      NULL,
    [CuryMultDiv]     CHAR (1)      NULL,
    [CuryRate]        FLOAT (53)    NULL,
    [CuryRateType]    CHAR (6)      NULL,
    [CuryTranamt]     FLOAT (53)    NULL,
    [data1]           CHAR (16)     NULL,
    [detail_num]      INT           NULL,
    [employee]        CHAR (10)     NULL,
    [fiscalno]        CHAR (6)      NULL,
    [gl_acct]         CHAR (10)     NULL,
    [gl_subacct]      CHAR (24)     NULL,
    [lupd_datetime]   SMALLDATETIME NULL,
    [lupd_prog]       CHAR (8)      NULL,
    [lupd_user]       CHAR (10)     NULL,
    [noteid]          INT           NULL,
    [pjt_entity]      CHAR (32)     NOT NULL,
    [post_date]       SMALLDATETIME NULL,
    [project]         CHAR (16)     NOT NULL,
    [system_cd]       CHAR (2)      NULL,
    [trans_date]      SMALLDATETIME NULL,
    [tr_comment]      CHAR (100)    NULL,
    [tr_id01]         CHAR (30)     NULL,
    [tr_id02]         CHAR (30)     NULL,
    [tr_id03]         CHAR (16)     NULL,
    [tr_id04]         CHAR (16)     NULL,
    [tr_id05]         CHAR (4)      NULL,
    [tr_id06]         FLOAT (53)    NULL,
    [tr_id07]         FLOAT (53)    NULL,
    [tr_id08]         SMALLDATETIME NULL,
    [tr_id09]         SMALLDATETIME NULL,
    [tr_id10]         INT           NULL,
    [tr_id23]         CHAR (30)     NULL,
    [tr_id24]         CHAR (20)     NULL,
    [tr_id25]         CHAR (20)     NULL,
    [tr_id26]         CHAR (10)     NULL,
    [tr_id27]         CHAR (4)      NULL,
    [tr_id28]         FLOAT (53)    NULL,
    [tr_id29]         SMALLDATETIME NULL,
    [tr_id30]         INT           NULL,
    [tr_id31]         FLOAT (53)    NULL,
    [tr_id32]         FLOAT (53)    NULL,
    [tr_status]       CHAR (10)     NULL,
    [unit_of_measure] CHAR (10)     NULL,
    [units]           FLOAT (53)    NULL,
    [user1]           CHAR (30)     NULL,
    [user2]           CHAR (30)     NULL,
    [user3]           FLOAT (53)    NULL,
    [user4]           FLOAT (53)    NULL,
    [vendor_num]      CHAR (15)     NULL,
    [voucher_line]    INT           NULL,
    [voucher_num]     CHAR (10)     NULL,
    [tstamp]          ROWVERSION    NULL
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[tempPJTRAN] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tempPJTRAN] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tempPJTRAN] TO PUBLIC
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tempPJTRAN] TO PUBLIC
    AS [dbo];

