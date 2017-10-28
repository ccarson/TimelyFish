CREATE TABLE [caredata].[HDR_FEED_BINS] (
    [bin_id]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [bin_name]         VARCHAR (30) NOT NULL,
    [capacity]         FLOAT (53)   NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_HDR_FEED_BINS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_HDR_FEED_BINS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_FEED_BINS] PRIMARY KEY NONCLUSTERED ([bin_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_HDR_FEED_BINS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_FEED_BINS_0]
    ON [caredata].[HDR_FEED_BINS]([bin_name] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

