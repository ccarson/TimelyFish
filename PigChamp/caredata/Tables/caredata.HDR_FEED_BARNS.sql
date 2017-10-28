CREATE TABLE [caredata].[HDR_FEED_BARNS] (
    [barn_id]                    INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]                    INT          NOT NULL,
    [barn_name]                  VARCHAR (30) NOT NULL,
    [open_date]                  DATETIME     NULL,
    [barn_type_id]               INT          NULL,
    [stage_of_production_id]     INT          NULL,
    [floor_type_id]              INT          NULL,
    [manure_storage_id]          INT          NULL,
    [feeder_type_id]             INT          NULL,
    [waterer_type_id]            INT          NULL,
    [ventilation_id]             INT          NULL,
    [controller_manufacturer_id] INT          NULL,
    [alarm_type_id]              INT          NULL,
    [alarm_manufacturer_id]      INT          NULL,
    [loading_chute_height_id]    INT          NULL,
    [loading_chute_type_id]      INT          NULL,
    [heated]                     BIT          NULL,
    [backup_power]               BIT          NULL,
    [turn_time]                  SMALLINT     NULL,
    [gross_area]                 INT          NULL,
    [creation_date]              DATETIME     CONSTRAINT [DF_HDR_FEED_BARNS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]                 VARCHAR (15) CONSTRAINT [DF_HDR_FEED_BARNS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]           DATETIME     NULL,
    [last_update_by]             VARCHAR (15) NULL,
    [deletion_date]              DATETIME     NULL,
    [deleted_by]                 VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_FEED_BARNS] PRIMARY KEY NONCLUSTERED ([barn_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_HDR_FEED_BARNS_COMMON_LOOKUPS_1] FOREIGN KEY ([controller_manufacturer_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]),
    CONSTRAINT [FK_HDR_FEED_BARNS_COMMON_LOOKUPS_2] FOREIGN KEY ([alarm_manufacturer_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_HDR_FEED_BARNS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_FEED_BARNS_0]
    ON [caredata].[HDR_FEED_BARNS]([barn_name] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

