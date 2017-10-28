CREATE TABLE [dbo].[PJTran] (
    [acct]                 CHAR (16)     NOT NULL,
    [alloc_flag]           CHAR (1)      NOT NULL,
    [amount]               FLOAT (53)    NOT NULL,
    [BaseCuryId]           CHAR (4)      NOT NULL,
    [batch_id]             CHAR (10)     NOT NULL,
    [batch_type]           CHAR (4)      NOT NULL,
    [bill_batch_id]        CHAR (10)     NOT NULL,
    [CpnyId]               CHAR (10)     NOT NULL,
    [crtd_datetime]        SMALLDATETIME NOT NULL,
    [crtd_prog]            CHAR (8)      NOT NULL,
    [crtd_user]            CHAR (10)     NOT NULL,
    [CuryEffDate]          SMALLDATETIME NOT NULL,
    [CuryId]               CHAR (4)      NOT NULL,
    [CuryMultDiv]          CHAR (1)      NOT NULL,
    [CuryRate]             FLOAT (53)    NOT NULL,
    [CuryRateType]         CHAR (6)      NOT NULL,
    [CuryTranamt]          FLOAT (53)    NOT NULL,
    [data1]                CHAR (16)     NOT NULL,
    [detail_num]           INT           NOT NULL,
    [employee]             CHAR (10)     NOT NULL,
    [fiscalno]             CHAR (6)      NOT NULL,
    [gl_acct]              CHAR (10)     NOT NULL,
    [gl_subacct]           CHAR (24)     NOT NULL,
    [lupd_datetime]        SMALLDATETIME NOT NULL,
    [lupd_prog]            CHAR (8)      NOT NULL,
    [lupd_user]            CHAR (10)     NOT NULL,
    [noteid]               INT           NOT NULL,
    [pjt_entity]           CHAR (32)     NOT NULL,
    [post_date]            SMALLDATETIME NOT NULL,
    [ProjCury_amount]      FLOAT (53)    NOT NULL,
    [ProjCuryEffDate]      SMALLDATETIME NOT NULL,
    [ProjCuryId]           CHAR (4)      NOT NULL,
    [ProjCuryMultiDiv]     CHAR (1)      NOT NULL,
    [ProjCuryRate]         FLOAT (53)    NOT NULL,
    [ProjCuryRateType]     CHAR (6)      NOT NULL,
    [project]              CHAR (16)     NOT NULL,
    [Subcontract]          CHAR (16)     NOT NULL,
    [SubTask_Name]         CHAR (50)     NOT NULL,
    [system_cd]            CHAR (2)      NOT NULL,
    [TranProjCuryEffDate]  SMALLDATETIME NOT NULL,
    [TranProjCuryId]       CHAR (4)      NOT NULL,
    [TranProjCuryMultiDiv] CHAR (1)      NOT NULL,
    [TranProjCuryRate]     FLOAT (53)    NOT NULL,
    [TranProjCuryRateType] CHAR (6)      NOT NULL,
    [trans_date]           SMALLDATETIME NOT NULL,
    [tr_comment]           CHAR (100)    NOT NULL,
    [tr_id01]              CHAR (30)     NOT NULL,
    [tr_id02]              CHAR (30)     NOT NULL,
    [tr_id03]              CHAR (16)     NOT NULL,
    [tr_id04]              CHAR (16)     NOT NULL,
    [tr_id05]              CHAR (4)      NOT NULL,
    [tr_id06]              FLOAT (53)    NOT NULL,
    [tr_id07]              FLOAT (53)    NOT NULL,
    [tr_id08]              SMALLDATETIME NOT NULL,
    [tr_id09]              SMALLDATETIME NOT NULL,
    [tr_id10]              INT           NOT NULL,
    [tr_id23]              CHAR (30)     NOT NULL,
    [tr_id24]              CHAR (20)     NOT NULL,
    [tr_id25]              CHAR (20)     NOT NULL,
    [tr_id26]              CHAR (10)     NOT NULL,
    [tr_id27]              CHAR (4)      NOT NULL,
    [tr_id28]              FLOAT (53)    NOT NULL,
    [tr_id29]              SMALLDATETIME NOT NULL,
    [tr_id30]              INT           NOT NULL,
    [tr_id31]              FLOAT (53)    NOT NULL,
    [tr_id32]              FLOAT (53)    NOT NULL,
    [tr_status]            CHAR (10)     NOT NULL,
    [unit_of_measure]      CHAR (10)     NOT NULL,
    [units]                FLOAT (53)    NOT NULL,
    [user1]                CHAR (30)     NOT NULL,
    [user2]                CHAR (30)     NOT NULL,
    [user3]                FLOAT (53)    NOT NULL,
    [user4]                FLOAT (53)    NOT NULL,
    [vendor_num]           CHAR (15)     NOT NULL,
    [voucher_line]         INT           NOT NULL,
    [voucher_num]          CHAR (10)     NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [pjtran0] PRIMARY KEY NONCLUSTERED ([fiscalno] ASC, [system_cd] ASC, [batch_id] ASC, [detail_num] ASC)
);


GO
CREATE CLUSTERED INDEX [pjtran1]
    ON [dbo].[PJTran]([project] ASC, [pjt_entity] ASC, [acct] ASC, [trans_date] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [pjtran2]
    ON [dbo].[PJTran]([project] ASC, [fiscalno] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [pjtran3]
    ON [dbo].[PJTran]([fiscalno] ASC, [project] ASC, [acct] ASC, [trans_date] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [pjtran4]
    ON [dbo].[PJTran]([acct] ASC, [pjt_entity] ASC)
    INCLUDE([amount], [units]) WITH (FILLFACTOR = 100);

