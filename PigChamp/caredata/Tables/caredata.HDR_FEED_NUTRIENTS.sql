CREATE TABLE [caredata].[HDR_FEED_NUTRIENTS] (
    [nutrient_id]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [nutrient_name]    VARCHAR (20) NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_HDR_FEED_NUTRIENTS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_HDR_FEED_NUTRIENTS_system] DEFAULT ((0)) NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_HDR_FEED_NUTRIENTS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_HDR_FEED_NUTRIENTS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_FEED_NUTRIENTS] PRIMARY KEY NONCLUSTERED ([nutrient_id] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_FEED_NUTRIENTS_0]
    ON [caredata].[HDR_FEED_NUTRIENTS]([nutrient_name] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 85);

