CREATE TABLE [careglobal].[SITES] (
    [site_id]           INT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [reporting_day]     TINYINT     CONSTRAINT [DF_SITES_reporting_day] DEFAULT ((1)) NOT NULL,
    [start_of_year_day] TINYINT     CONSTRAINT [DF_SITES_start_of_year_day] DEFAULT ((1)) NOT NULL,
    [start_of_year_mth] TINYINT     CONSTRAINT [DF_SITES_start_of_year_mth] DEFAULT ((1)) NOT NULL,
    [zero_date]         DATETIME    NOT NULL,
    [contemp_grp_prds]  TINYINT     CONSTRAINT [DF_SITES_contemp_grp_prds] DEFAULT ((1)) NOT NULL,
    [active]            BIT         CONSTRAINT [DF_SITES_active] DEFAULT ((0)) NOT NULL,
    [currency_unit]     VARCHAR (3) NULL,
    [weight_unit]       TINYINT     NULL,
    CONSTRAINT [PK_SITES] PRIMARY KEY CLUSTERED ([site_id] ASC) WITH (FILLFACTOR = 80)
);

