CREATE TABLE [caredata].[HDR_FEED_LOCATIONS] (
    [location_id]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [barn_id]          INT          NOT NULL,
    [location_name]    VARCHAR (30) NOT NULL,
    [pig_spaces]       INT          NOT NULL,
    [capacity]         INT          NOT NULL,
    [area]             INT          NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_HDR_FEED_LOCATIONS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_HDR_FEED_LOCATIONS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_FEED_LOCATIONS] PRIMARY KEY NONCLUSTERED ([location_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_HDR_FEED_LOCATIONS_HDR_FEED_BARNS_0] FOREIGN KEY ([barn_id]) REFERENCES [caredata].[HDR_FEED_BARNS] ([barn_id]) ON DELETE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_FEED_LOCATIONS_0]
    ON [caredata].[HDR_FEED_LOCATIONS]([location_name] ASC, [barn_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

