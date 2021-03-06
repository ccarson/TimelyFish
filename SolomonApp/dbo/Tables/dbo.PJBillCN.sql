﻿CREATE TABLE [dbo].[PJBillCN] (
    [acct]                CHAR (16)     NOT NULL,
    [amt_data]            FLOAT (53)    NOT NULL,
    [amt_matl]            FLOAT (53)    NOT NULL,
    [amt_prev]            FLOAT (53)    NOT NULL,
    [amt_ret]             FLOAT (53)    NOT NULL,
    [amt_ret_prev]        FLOAT (53)    NOT NULL,
    [amt_sched_value]     FLOAT (53)    NOT NULL,
    [amt_work]            FLOAT (53)    NOT NULL,
    [appnbr]              CHAR (6)      NOT NULL,
    [bn_01]               CHAR (30)     NOT NULL,
    [bn_02]               CHAR (30)     NOT NULL,
    [bn_03]               CHAR (16)     NOT NULL,
    [bn_04]               CHAR (16)     NOT NULL,
    [bn_05]               CHAR (4)      NOT NULL,
    [bn_06]               FLOAT (53)    NOT NULL,
    [bn_07]               FLOAT (53)    NOT NULL,
    [bn_08]               SMALLDATETIME NOT NULL,
    [bn_09]               SMALLDATETIME NOT NULL,
    [bn_10]               INT           NOT NULL,
    [bn_11]               CHAR (30)     NOT NULL,
    [bn_12]               CHAR (30)     NOT NULL,
    [bn_13]               CHAR (16)     NOT NULL,
    [bn_14]               CHAR (16)     NOT NULL,
    [bn_15]               CHAR (4)      NOT NULL,
    [bn_16]               FLOAT (53)    NOT NULL,
    [bn_17]               FLOAT (53)    NOT NULL,
    [bn_18]               SMALLDATETIME NOT NULL,
    [bn_19]               SMALLDATETIME NOT NULL,
    [bn_20]               INT           NOT NULL,
    [change_order_num]    CHAR (16)     NOT NULL,
    [co_approval_date]    SMALLDATETIME NOT NULL,
    [CpnyId]              CHAR (10)     NOT NULL,
    [crtd_datetime]       SMALLDATETIME NOT NULL,
    [crtd_prog]           CHAR (8)      NOT NULL,
    [crtd_user]           CHAR (10)     NOT NULL,
    [CuryId]              CHAR (4)      NOT NULL,
    [CuryMultDiv]         CHAR (1)      NOT NULL,
    [CuryRate]            FLOAT (53)    NOT NULL,
    [CuryAmt_Data]        FLOAT (53)    NOT NULL,
    [CuryAmt_Matl]        FLOAT (53)    NOT NULL,
    [CuryAmt_Prev]        FLOAT (53)    NOT NULL,
    [CuryAmt_Ret]         FLOAT (53)    NOT NULL,
    [CuryAmt_Ret_Prev]    FLOAT (53)    NOT NULL,
    [CuryAmt_Sched_Value] FLOAT (53)    NOT NULL,
    [CuryAmt_Work]        FLOAT (53)    NOT NULL,
    [desc_work]           CHAR (40)     NOT NULL,
    [itemnbr]             CHAR (6)      NOT NULL,
    [lupd_datetime]       SMALLDATETIME NOT NULL,
    [lupd_prog]           CHAR (8)      NOT NULL,
    [lupd_user]           CHAR (10)     NOT NULL,
    [noteid]              INT           NOT NULL,
    [percent_comp]        FLOAT (53)    NOT NULL,
    [project]             CHAR (16)     NOT NULL,
    [pjt_entity]          CHAR (32)     NOT NULL,
    [retention_method]    CHAR (2)      NOT NULL,
    [retention_percent1]  FLOAT (53)    NOT NULL,
    [retention_percent2]  FLOAT (53)    NOT NULL,
    [status_co]           CHAR (1)      NOT NULL,
    [subtotal_flag]       CHAR (2)      NOT NULL,
    [user1]               CHAR (30)     NOT NULL,
    [user2]               CHAR (30)     NOT NULL,
    [user3]               FLOAT (53)    NOT NULL,
    [user4]               FLOAT (53)    NOT NULL,
    [user5]               CHAR (30)     NOT NULL,
    [user6]               CHAR (30)     NOT NULL,
    [user7]               FLOAT (53)    NOT NULL,
    [user8]               FLOAT (53)    NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [pjbillcn0] PRIMARY KEY NONCLUSTERED ([project] ASC, [appnbr] ASC, [itemnbr] ASC, [change_order_num] ASC)
);


GO
CREATE UNIQUE CLUSTERED INDEX [PJBILLCN1]
    ON [dbo].[PJBillCN]([project] ASC, [appnbr] ASC, [subtotal_flag] ASC, [itemnbr] ASC, [change_order_num] ASC);

