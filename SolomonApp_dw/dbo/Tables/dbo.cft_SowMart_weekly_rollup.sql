CREATE TABLE [dbo].[cft_SowMart_weekly_rollup] (
    [PicYear_week]     VARCHAR (6) NOT NULL,
    [FarmID]           VARCHAR (8) NOT NULL,
    [SiteID]           INT         NOT NULL,
    [Total_sow_qty]    FLOAT (53)  NULL,
    [Gest_sow_qty]     FLOAT (53)  NULL,
    [Lact_sow_qty]     FLOAT (53)  NULL,
    [NonProd_sow_qty]  FLOAT (53)  NULL,
    [Total_sow_days]   FLOAT (53)  NULL,
    [Gest_sow_Days]    FLOAT (53)  NULL,
    [Lact_sow_Days]    FLOAT (53)  NULL,
    [NonProd_sow_Days] FLOAT (53)  NULL,
    [Gest_feed_lbs]    FLOAT (53)  NULL,
    [Lact_feed_lbs]    FLOAT (53)  NULL,
    [other_feed_lbs]   FLOAT (53)  NULL,
    [reportinggroupid] INT         NULL,
    [load_Dt]          DATETIME    NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [idx_PK_cft_sowmart_weekly_rollup]
    ON [dbo].[cft_SowMart_weekly_rollup]([PicYear_week] ASC, [FarmID] ASC, [SiteID] ASC, [reportinggroupid] ASC) WITH (FILLFACTOR = 100);

