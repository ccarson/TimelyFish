CREATE TABLE [dbo].[PJCOMDET] (
    [acct]                 CHAR (16)     NOT NULL,
    [amount]               FLOAT (53)    NOT NULL,
    [BaseCuryId]           CHAR (4)      NOT NULL,
    [batch_id]             CHAR (10)     NOT NULL,
    [batch_type]           CHAR (4)      NOT NULL,
    [bill_batch_id]        CHAR (10)     NOT NULL,
    [cd_id01]              CHAR (30)     NOT NULL,
    [cd_id02]              CHAR (30)     NOT NULL,
    [cd_id03]              CHAR (16)     NOT NULL,
    [cd_id04]              CHAR (16)     NOT NULL,
    [cd_id05]              CHAR (4)      NOT NULL,
    [cd_id06]              FLOAT (53)    NOT NULL,
    [cd_id07]              FLOAT (53)    NOT NULL,
    [cd_id08]              SMALLDATETIME NOT NULL,
    [cd_id09]              SMALLDATETIME NOT NULL,
    [cd_id10]              INT           NOT NULL,
    [cpnyId]               CHAR (10)     NOT NULL,
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
    [fiscalno]             CHAR (6)      NOT NULL,
    [gl_acct]              CHAR (10)     NOT NULL,
    [gl_subacct]           CHAR (24)     NOT NULL,
    [lupd_datetime]        SMALLDATETIME NOT NULL,
    [lupd_prog]            CHAR (8)      NOT NULL,
    [lupd_user]            CHAR (10)     NOT NULL,
    [part_number]          CHAR (24)     NOT NULL,
    [pjt_entity]           CHAR (32)     NOT NULL,
    [po_date]              SMALLDATETIME NOT NULL,
    [ProjCury_amount]      FLOAT (53)    NOT NULL,
    [ProjCuryEffDate]      SMALLDATETIME NOT NULL,
    [ProjCuryId]           CHAR (4)      NOT NULL,
    [ProjCuryMultiDiv]     CHAR (1)      NOT NULL,
    [ProjCuryRate]         FLOAT (53)    NOT NULL,
    [ProjCuryRateType]     CHAR (6)      NOT NULL,
    [project]              CHAR (16)     NOT NULL,
    [projinv_lineref]      CHAR (5)      NOT NULL,
    [projinv_receipt_num]  CHAR (15)     NOT NULL,
    [projinv_referenc_num] CHAR (15)     NOT NULL,
    [promise_date]         SMALLDATETIME NOT NULL,
    [purchase_order_num]   CHAR (20)     NOT NULL,
    [request_date]         SMALLDATETIME NOT NULL,
    [sub_line_item]        CHAR (4)      NOT NULL,
    [system_cd]            CHAR (2)      NOT NULL,
    [tr_comment]           CHAR (30)     NOT NULL,
    [tr_status]            CHAR (10)     NOT NULL,
    [units]                FLOAT (53)    NOT NULL,
    [unit_of_measure]      CHAR (10)     NOT NULL,
    [user1]                CHAR (30)     NOT NULL,
    [user2]                CHAR (30)     NOT NULL,
    [user3]                FLOAT (53)    NOT NULL,
    [user4]                FLOAT (53)    NOT NULL,
    [vendor_num]           CHAR (15)     NOT NULL,
    [voucher_line]         INT           NOT NULL,
    [voucher_num]          CHAR (10)     NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL,
    CONSTRAINT [pjcomdet0] PRIMARY KEY CLUSTERED ([fiscalno] ASC, [system_cd] ASC, [batch_id] ASC, [detail_num] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [pjcomdet1]
    ON [dbo].[PJCOMDET]([project] ASC, [pjt_entity] ASC, [acct] ASC, [po_date] ASC);


GO
CREATE NONCLUSTERED INDEX [pjcomdet2]
    ON [dbo].[PJCOMDET]([purchase_order_num] ASC, [voucher_line] ASC);


GO
CREATE NONCLUSTERED INDEX [pjcomdet3]
    ON [dbo].[PJCOMDET]([project] ASC, [cd_id04] ASC, [sub_line_item] ASC);

