CREATE TABLE [careglobal].[REPORT_GROUPS] (
    [group_id]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [group_name]      VARCHAR (40) NOT NULL,
    [product_context] VARCHAR (1)  CONSTRAINT [DF_REPORT_GROUPS_product_context] DEFAULT ('R') NOT NULL,
    [site_type]       VARCHAR (1)  CONSTRAINT [DF_REPORT_GROUPS_site_type] DEFAULT ('B') NOT NULL,
    [user_defined]    BIT          CONSTRAINT [DF_REPORT_GROUPS_user_defined] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_REPORT_GROUPS] PRIMARY KEY CLUSTERED ([group_id] ASC) WITH (FILLFACTOR = 80)
);

