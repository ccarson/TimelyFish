CREATE TABLE [dbo].[PJPROJ] (
    [alloc_method_cd]     CHAR (4)      NOT NULL,
    [alloc_method2_cd]    CHAR (4)      NOT NULL,
    [BaseCuryId]          CHAR (4)      NOT NULL,
    [bf_values_switch]    CHAR (1)      NOT NULL,
    [billcuryfixedrate]   FLOAT (53)    NOT NULL,
    [billcuryid]          CHAR (4)      NOT NULL,
    [billing_setup]       CHAR (1)      NOT NULL,
    [billratetypeid]      CHAR (6)      NOT NULL,
    [budget_type]         CHAR (1)      NOT NULL,
    [budget_version]      CHAR (2)      NOT NULL,
    [contract]            CHAR (16)     NOT NULL,
    [contract_type]       CHAR (4)      NOT NULL,
    [CpnyId]              CHAR (10)     NOT NULL,
    [crtd_datetime]       SMALLDATETIME NOT NULL,
    [crtd_prog]           CHAR (8)      NOT NULL,
    [crtd_user]           CHAR (10)     NOT NULL,
    [CuryId]              CHAR (4)      NOT NULL,
    [CuryRateType]        CHAR (6)      NOT NULL,
    [customer]            CHAR (15)     NOT NULL,
    [end_date]            SMALLDATETIME NOT NULL,
    [gl_subacct]          CHAR (24)     NOT NULL,
    [labor_gl_acct]       CHAR (10)     NOT NULL,
    [lupd_datetime]       SMALLDATETIME NOT NULL,
    [lupd_prog]           CHAR (8)      NOT NULL,
    [lupd_user]           CHAR (10)     NOT NULL,
    [manager1]            CHAR (10)     NOT NULL,
    [manager2]            CHAR (10)     NOT NULL,
    [MSPData]             CHAR (50)     NOT NULL,
    [MSPInterface]        CHAR (1)      NOT NULL,
    [MSPProj_ID]          INT           NOT NULL,
    [noteid]              INT           NOT NULL,
    [opportunityID]       CHAR (36)     NOT NULL,
    [pm_id01]             CHAR (30)     NOT NULL,
    [pm_id02]             CHAR (30)     NOT NULL,
    [pm_id03]             CHAR (16)     NOT NULL,
    [pm_id04]             CHAR (16)     NOT NULL,
    [pm_id05]             CHAR (4)      NOT NULL,
    [pm_id06]             FLOAT (53)    NOT NULL,
    [pm_id07]             FLOAT (53)    NOT NULL,
    [pm_id08]             SMALLDATETIME NOT NULL,
    [pm_id09]             SMALLDATETIME NOT NULL,
    [pm_id10]             INT           NOT NULL,
    [pm_id31]             CHAR (30)     NOT NULL,
    [pm_id32]             CHAR (30)     NOT NULL,
    [pm_id33]             CHAR (20)     NOT NULL,
    [pm_id34]             CHAR (20)     NOT NULL,
    [pm_id35]             CHAR (10)     NOT NULL,
    [pm_id36]             CHAR (10)     NOT NULL,
    [pm_id37]             CHAR (4)      NOT NULL,
    [pm_id38]             FLOAT (53)    NOT NULL,
    [pm_id39]             SMALLDATETIME NOT NULL,
    [pm_id40]             INT           NOT NULL,
    [probability]         SMALLINT      NOT NULL,
    [ProjCuryId]          CHAR (4)      NOT NULL,
    [ProjCuryRateType]    CHAR (6)      NOT NULL,
    [ProjCuryBudEffDate]  SMALLDATETIME NOT NULL,
    [ProjCuryBudMultiDiv] CHAR (1)      NOT NULL,
    [ProjCuryBudRate]     FLOAT (53)    NOT NULL,
    [ProjCuryRevenueRec]  CHAR (1)      NOT NULL,
    [project]             CHAR (16)     NOT NULL,
    [project_desc]        CHAR (60)     NOT NULL,
    [purchase_order_num]  CHAR (20)     NOT NULL,
    [rate_table_id]       CHAR (4)      NOT NULL,
    [shiptoid]            CHAR (10)     NOT NULL,
    [slsperid]            CHAR (10)     NOT NULL,
    [start_date]          SMALLDATETIME NOT NULL,
    [status_08]           CHAR (1)      NOT NULL,
    [status_09]           CHAR (1)      NOT NULL,
    [status_10]           CHAR (1)      NOT NULL,
    [status_11]           CHAR (1)      NOT NULL,
    [status_12]           CHAR (1)      NOT NULL,
    [status_13]           CHAR (1)      NOT NULL,
    [status_14]           CHAR (1)      NOT NULL,
    [status_15]           CHAR (1)      NOT NULL,
    [status_16]           CHAR (1)      NOT NULL,
    [status_17]           CHAR (1)      NOT NULL,
    [status_18]           CHAR (1)      NOT NULL,
    [status_19]           CHAR (1)      NOT NULL,
    [status_20]           CHAR (1)      NOT NULL,
    [status_ap]           CHAR (1)      NOT NULL,
    [status_ar]           CHAR (1)      NOT NULL,
    [status_gl]           CHAR (1)      NOT NULL,
    [status_in]           CHAR (1)      NOT NULL,
    [status_lb]           CHAR (1)      NOT NULL,
    [status_pa]           CHAR (1)      NOT NULL,
    [status_po]           CHAR (1)      NOT NULL,
    [user1]               CHAR (30)     NOT NULL,
    [user2]               CHAR (30)     NOT NULL,
    [user3]               FLOAT (53)    NOT NULL,
    [user4]               FLOAT (53)    NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [pjproj0] PRIMARY KEY CLUSTERED ([project] ASC)
);


GO
CREATE NONCLUSTERED INDEX [pjproj1]
    ON [dbo].[PJPROJ]([manager1] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj2]
    ON [dbo].[PJPROJ]([manager2] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj3]
    ON [dbo].[PJPROJ]([gl_subacct] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj4]
    ON [dbo].[PJPROJ]([alloc_method_cd] ASC, [rate_table_id] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj5]
    ON [dbo].[PJPROJ]([project_desc] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj6]
    ON [dbo].[PJPROJ]([customer] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj7]
    ON [dbo].[PJPROJ]([contract] ASC);


GO
CREATE NONCLUSTERED INDEX [pjproj8]
    ON [dbo].[PJPROJ]([CpnyId] ASC, [rate_table_id] ASC, [alloc_method_cd] ASC, [gl_subacct] ASC, [status_pa] ASC)
    INCLUDE([project], [alloc_method2_cd]);

