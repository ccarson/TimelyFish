CREATE TABLE [caredata].[COMMON_LOOKUPS] (
    [lookup_id]        INT          NOT NULL,
    [site_id]          INT          NULL,
    [lookup_category]  VARCHAR (3)  NOT NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NULL,
    [disabled]         BIT          CONSTRAINT [DF_COMMON_LOOKUPS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_COMMON_LOOKUPS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_COMMON_LOOKUPS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_COMMON_LOOKUPS] PRIMARY KEY CLUSTERED ([lookup_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_COMMON_LOOKUPS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_COMMON_LOOKUPS_0]
    ON [caredata].[COMMON_LOOKUPS]([shortname] ASC, [lookup_category] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

