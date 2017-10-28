CREATE TABLE [careglobal].[REPORTS] (
    [report_id]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [report_name]      VARCHAR (40) NOT NULL,
    [parent_report_id] INT          NULL,
    [active]           BIT          CONSTRAINT [DF_REPORTS_active] DEFAULT ((1)) NOT NULL,
    [menu_display]     BIT          CONSTRAINT [DF_REPORTS_menu_display] DEFAULT ((1)) NOT NULL,
    [product_context]  VARCHAR (1)  CONSTRAINT [DF_REPORTS_product_context] DEFAULT ('R') NOT NULL,
    [site_type]        VARCHAR (1)  CONSTRAINT [DF_REPORTS_site_type] DEFAULT ('B') NOT NULL,
    CONSTRAINT [PK_REPORTS] PRIMARY KEY CLUSTERED ([report_id] ASC) WITH (FILLFACTOR = 80)
);

