CREATE TABLE [dbo].[PJInvDet] (
    [acct]              CHAR (16)     NOT NULL,
    [acct_rev]          CHAR (16)     NOT NULL,
    [adj_amount]        FLOAT (53)    NOT NULL,
    [adj_units]         FLOAT (53)    NOT NULL,
    [amount]            FLOAT (53)    NOT NULL,
    [bill_status]       CHAR (1)      NOT NULL,
    [burdened_amt]      FLOAT (53)    NOT NULL,
    [comment]           CHAR (250)    NOT NULL,
    [cost_amt]          FLOAT (53)    NOT NULL,
    [CpnyId]            CHAR (10)     NOT NULL,
    [crtd_datetime]     SMALLDATETIME NOT NULL,
    [crtd_prog]         CHAR (8)      NOT NULL,
    [crtd_user]         CHAR (10)     NOT NULL,
    [CuryAdj_amount]    FLOAT (53)    NOT NULL,
    [CuryHold_amount]   FLOAT (53)    NOT NULL,
    [CuryId]            CHAR (4)      NOT NULL,
    [CuryMultDiv]       CHAR (1)      NOT NULL,
    [CuryOrig_amount]   FLOAT (53)    NOT NULL,
    [CuryRate]          FLOAT (53)    NOT NULL,
    [CuryTranamt]       FLOAT (53)    NOT NULL,
    [data1]             CHAR (10)     NOT NULL,
    [data2]             CHAR (24)     NOT NULL,
    [data3]             CHAR (2)      NOT NULL,
    [draft_num]         CHAR (10)     NOT NULL,
    [employee]          CHAR (10)     NOT NULL,
    [entry_type]        CHAR (1)      NOT NULL,
    [equip_id]          CHAR (10)     NOT NULL,
    [fee_rate]          FLOAT (53)    NOT NULL,
    [fiscalno]          CHAR (6)      NOT NULL,
    [gl_acct]           CHAR (10)     NOT NULL,
    [gl_offset_cpnyid]  CHAR (10)     NOT NULL,
    [gl_offset_acct]    CHAR (10)     NOT NULL,
    [gl_offset_subacct] CHAR (24)     NOT NULL,
    [gl_subacct]        CHAR (24)     NOT NULL,
    [hold_status]       CHAR (2)      NOT NULL,
    [hold_amount]       FLOAT (53)    NOT NULL,
    [hold_units]        FLOAT (53)    NOT NULL,
    [in_id01]           CHAR (30)     NOT NULL,
    [in_id02]           CHAR (30)     NOT NULL,
    [in_id03]           CHAR (16)     NOT NULL,
    [in_id04]           CHAR (16)     NOT NULL,
    [in_id05]           CHAR (4)      NOT NULL,
    [in_id06]           FLOAT (53)    NOT NULL,
    [in_id07]           FLOAT (53)    NOT NULL,
    [in_id08]           SMALLDATETIME NOT NULL,
    [in_id09]           SMALLDATETIME NOT NULL,
    [in_id10]           SMALLINT      NOT NULL,
    [in_id11]           CHAR (30)     NOT NULL,
    [in_id12]           CHAR (30)     NOT NULL,
    [in_id13]           CHAR (30)     NOT NULL,
    [in_id14]           CHAR (20)     NOT NULL,
    [in_id15]           CHAR (15)     NOT NULL,
    [in_id16]           CHAR (10)     NOT NULL,
    [in_id17]           CHAR (10)     NOT NULL,
    [in_id18]           CHAR (4)      NOT NULL,
    [in_id19]           FLOAT (53)    NOT NULL,
    [in_id20]           SMALLDATETIME NOT NULL,
    [in_id21]           FLOAT (53)    NOT NULL,
    [in_id22]           FLOAT (53)    NOT NULL,
    [in_id23]           FLOAT (53)    NOT NULL,
    [labor_class_cd]    CHAR (4)      NOT NULL,
    [linenbr]           SMALLINT      NOT NULL,
    [li_type]           CHAR (1)      NOT NULL,
    [lupd_datetime]     SMALLDATETIME NOT NULL,
    [lupd_prog]         CHAR (8)      NOT NULL,
    [lupd_user]         CHAR (10)     NOT NULL,
    [noteid]            INT           NOT NULL,
    [offset_cd]         CHAR (4)      NOT NULL,
    [orig_amount]       FLOAT (53)    NOT NULL,
    [orig_rate]         FLOAT (53)    NOT NULL,
    [orig_units]        FLOAT (53)    NOT NULL,
    [pjt_entity]        CHAR (32)     NOT NULL,
    [post_to_cd]        CHAR (4)      NOT NULL,
    [project]           CHAR (16)     NOT NULL,
    [project_billwith]  CHAR (16)     NOT NULL,
    [rate_type_cd]      CHAR (2)      NOT NULL,
    [ShipperID]         CHAR (15)     DEFAULT (' ') NOT NULL,
    [ShipperLineRef]    CHAR (5)      DEFAULT (' ') NOT NULL,
    [source_trx_date]   SMALLDATETIME NOT NULL,
    [source_trx_id]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Subcontract]       CHAR (16)     NOT NULL,
    [SubTask_Name]      CHAR (50)     NOT NULL,
    [taxcatid]          CHAR (10)     NOT NULL,
    [taxId]             CHAR (10)     NOT NULL,
    [taxitembasis]      FLOAT (53)    NOT NULL,
    [TranClass]         CHAR (1)      DEFAULT (' ') NOT NULL,
    [unit_of_measure]   CHAR (10)     NOT NULL,
    [units]             FLOAT (53)    NOT NULL,
    [user1]             CHAR (30)     NOT NULL,
    [user2]             CHAR (30)     NOT NULL,
    [user3]             FLOAT (53)    NOT NULL,
    [user4]             FLOAT (53)    NOT NULL,
    [vendor_num]        CHAR (15)     NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [pjinvdet0] PRIMARY KEY NONCLUSTERED ([source_trx_id] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE CLUSTERED INDEX [pjinvdet1]
    ON [dbo].[PJInvDet]([project_billwith] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjinvdet2]
    ON [dbo].[PJInvDet]([draft_num] ASC, [source_trx_date] ASC, [project_billwith] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjinvdet3]
    ON [dbo].[PJInvDet]([project] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjinvdet4]
    ON [dbo].[PJInvDet]([employee] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjinvdet5]
    ON [dbo].[PJInvDet]([bill_status] ASC, [project_billwith] ASC) WITH (FILLFACTOR = 90);

