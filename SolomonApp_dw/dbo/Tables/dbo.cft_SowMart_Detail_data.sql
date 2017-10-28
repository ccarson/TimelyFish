CREATE TABLE [dbo].[cft_SowMart_Detail_data] (
    [FarmID]                  VARCHAR (8)   NOT NULL,
    [SiteID]                  INT           NOT NULL,
    [GroupID]                 VARCHAR (15)  NOT NULL,
    [SowID]                   VARCHAR (12)  NOT NULL,
    [IdentityID]              INT           NOT NULL,
    [SowParity]               SMALLINT      NOT NULL,
    [arrival_date]            SMALLDATETIME NULL,
    [arrival_picyear_week]    VARCHAR (6)   NULL,
    [mating_date]             SMALLDATETIME NULL,
    [mating_picyear_week]     VARCHAR (6)   NULL,
    [fallout_date]            SMALLDATETIME NULL,
    [fallout_picyear_week]    VARCHAR (6)   NULL,
    [farrow_date]             SMALLDATETIME NULL,
    [farrow_picyear_week]     VARCHAR (6)   NULL,
    [removal_date]            SMALLDATETIME NULL,
    [removal_picyear_week]    VARCHAR (6)   NULL,
    [first_wean_date]         SMALLDATETIME NULL,
    [first_wean_picyear_week] VARCHAR (6)   NULL,
    [final_wean_date]         SMALLDATETIME NULL,
    [final_wean_picyear_week] VARCHAR (6)   NULL,
    [Total_born_qty]          INT           NULL,
    [born_alive_qty]          INT           NULL,
    [mummy_qty]               INT           NULL,
    [Stillborn_qty]           INT           NULL,
    [first_wean_qty]          INT           NULL,
    [wean_qty]                INT           NULL,
    [PigletDeath_qty]         INT           NULL,
    [NurseOn_date]            SMALLDATETIME NULL,
    [NurseOn_picyear_week]    VARCHAR (6)   NULL,
    [NurseOn_Qty]             INT           NULL,
    [wean_age]                FLOAT (53)    NULL,
    [pigflowid]               INT           NULL,
    [reportinggroupid]        INT           NULL,
    [lact_days_qty]           INT           NULL,
    [gest_days_qty]           INT           NULL,
    [SemenID]                 VARCHAR (12)  NULL,
    [Observer]                VARCHAR (30)  NULL,
    [MatingNbr]               INT           NULL,
    [SowGenetics]             VARCHAR (20)  NULL,
    [MatingEventID]           INT           NULL,
    [load_Dt]                 DATETIME      DEFAULT (getdate()) NOT NULL,
    [PigChampGeneticName]     VARCHAR (30)  NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [idx_PK_SowMart_Detail_data]
    ON [dbo].[cft_SowMart_Detail_data]([FarmID] ASC, [SiteID] ASC, [GroupID] ASC, [IdentityID] ASC, [SowID] ASC, [SowParity] ASC, [mating_date] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cfi_cft_sowmart_table_identityid]
    ON [dbo].[cft_SowMart_Detail_data]([IdentityID] ASC, [mating_date] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cft_SowMart_Detail_data_4daily]
    ON [dbo].[cft_SowMart_Detail_data]([FarmID] ASC, [mating_date] ASC, [farrow_date] ASC)
    INCLUDE([SiteID], [GroupID], [SowID], [IdentityID], [SowParity], [fallout_date], [removal_date], [final_wean_date], [lact_days_qty], [gest_days_qty]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_CFT_SOWMART_DETAIL_DATA_ACTV]
    ON [dbo].[cft_SowMart_Detail_data]([FarmID] ASC, [arrival_date] ASC)
    INCLUDE([IdentityID], [removal_date]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cft_SowMart_Detail_data_farmid_incl]
    ON [dbo].[cft_SowMart_Detail_data]([FarmID] ASC)
    INCLUDE([SiteID], [IdentityID], [arrival_picyear_week], [removal_picyear_week]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cft_SowMart_Detail_data_rg_farrowweek_incl]
    ON [dbo].[cft_SowMart_Detail_data]([reportinggroupid] ASC, [farrow_picyear_week] ASC)
    INCLUDE([born_alive_qty], [wean_age], [lact_days_qty], [gest_days_qty], [mummy_qty], [Stillborn_qty], [NurseOn_Qty], [wean_qty]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cft_sowmart_table_identityid]
    ON [dbo].[cft_SowMart_Detail_data]([IdentityID] ASC, [mating_date] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_sowmart_detail_data_uniq]
    ON [dbo].[cft_SowMart_Detail_data]([SiteID] ASC, [GroupID] ASC, [IdentityID] ASC, [SowParity] ASC, [mating_date] ASC) WITH (FILLFACTOR = 90);

