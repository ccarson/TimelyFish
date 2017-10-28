CREATE TABLE [caredata].[EV_ENVIRONMENT_DATA] (
    [event_id]            INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [environment_type_id] INT          NOT NULL,
    [site_id]             INT          NOT NULL,
    [barn_id]             INT          NULL,
    [location_id]         INT          NULL,
    [value1]              FLOAT (53)   NOT NULL,
    [value2]              FLOAT (53)   NULL,
    [date_from]           DATETIME     NOT NULL,
    [date_to]             DATETIME     NULL,
    [creation_date]       DATETIME     CONSTRAINT [DF_EV_ENVIRONMENT_DATA_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]          VARCHAR (15) CONSTRAINT [DF_EV_ENVIRONMENT_DATA_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]    DATETIME     NULL,
    [last_update_by]      VARCHAR (15) NULL,
    [deletion_date]       DATETIME     NULL,
    [deleted_by]          VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_ENVIRONMENT_DATA] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_ENVIRONMENT_DATA_ENVIRONMENT_DATA_TYPES_0] FOREIGN KEY ([environment_type_id]) REFERENCES [caredata].[ENVIRONMENT_DATA_TYPES] ([environment_type_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_ENVIRONMENT_DATA_HDR_FEED_BARNS_2] FOREIGN KEY ([barn_id]) REFERENCES [caredata].[HDR_FEED_BARNS] ([barn_id]),
    CONSTRAINT [FK_EV_ENVIRONMENT_DATA_HDR_FEED_LOCATIONS_3] FOREIGN KEY ([location_id]) REFERENCES [caredata].[HDR_FEED_LOCATIONS] ([location_id]),
    CONSTRAINT [FK_EV_ENVIRONMENT_DATA_SITES_1] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

