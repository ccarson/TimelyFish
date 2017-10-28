CREATE TABLE [careglobal].[FARM_GROUPS] (
    [site_id]    INT          NOT NULL,
    [group_name] VARCHAR (30) NOT NULL,
    [farm_type]  TINYINT      CONSTRAINT [DF_FARM_GROUPS_farm_type] DEFAULT ((0)) NOT NULL,
    [company_id] INT          NULL,
    CONSTRAINT [PK_FARM_GROUPS] PRIMARY KEY CLUSTERED ([site_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_FARM_GROUPS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

