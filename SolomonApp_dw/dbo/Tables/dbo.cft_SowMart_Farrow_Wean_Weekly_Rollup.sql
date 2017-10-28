CREATE TABLE [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] (
    [PicYear_week]         VARCHAR (6) NOT NULL,
    [PigFlowID]            INT         NOT NULL,
    [ReportingGroupID]     INT         NOT NULL,
    [FarmID]               VARCHAR (8) NOT NULL,
    [SiteID]               INT         NOT NULL,
    [Total_Born_qty]       INT         NULL,
    [Born_Alive_qty]       INT         NULL,
    [Mummy_qty]            INT         NULL,
    [StillBorn_qty]        INT         NULL,
    [PigletDeath_qty]      INT         NULL,
    [NurseOn_qty]          INT         NULL,
    [Litters_farrowed_qty] INT         NULL,
    [Wean_qty]             INT         NULL,
    [Litters_weaned_qty]   INT         NULL,
    [avg_wean_age]         FLOAT (53)  NULL,
    [born_alive_pct]       FLOAT (53)  NULL,
    [mummy_pct]            FLOAT (53)  NULL,
    [stillborn_pct]        FLOAT (53)  NULL,
    [pigletdeath_pct]      FLOAT (53)  NULL,
    [nurseon_pct]          FLOAT (53)  NULL,
    [wean_pct]             FLOAT (53)  NULL,
    [litters_farrowed_pct] FLOAT (53)  NULL,
    [litters_weaned_pct]   FLOAT (53)  NULL,
    [load_DT]              DATETIME    DEFAULT (getdate()) NOT NULL,
    [min_wean_age]         FLOAT (53)  NULL,
    [max_wean_age]         FLOAT (53)  NULL,
    [stddev_wean_age]      FLOAT (53)  NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [idx_pk_cft_sowmart_farrow_wean_weekly_rollup]
    ON [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup]([PicYear_week] ASC, [PigFlowID] ASC, [ReportingGroupID] ASC, [FarmID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cft_sowmart_farrow_wean_weekly_rollup_rg_week_incl]
    ON [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup]([ReportingGroupID] ASC, [PicYear_week] ASC)
    INCLUDE([Born_Alive_qty], [Mummy_qty], [StillBorn_qty], [NurseOn_qty], [Wean_qty]) WITH (FILLFACTOR = 90);

