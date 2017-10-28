CREATE TABLE [caredata].[LOCATIONS] (
    [location_id]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [barn]             VARCHAR (10) NOT NULL,
    [room]             VARCHAR (10) NULL,
    [pen]              VARCHAR (10) NULL,
    [station_id]       INT          NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_LOCATIONS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_LOCATIONS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_LOCATIONS] PRIMARY KEY CLUSTERED ([location_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_LOCATIONS_FEEDING_STATIONS_1] FOREIGN KEY ([station_id]) REFERENCES [caredata].[FEEDING_STATIONS] ([station_id]) ON DELETE SET NULL,
    CONSTRAINT [FK_LOCATIONS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_LOCATIONS_0]
    ON [caredata].[LOCATIONS]([barn] ASC, [room] ASC, [pen] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

