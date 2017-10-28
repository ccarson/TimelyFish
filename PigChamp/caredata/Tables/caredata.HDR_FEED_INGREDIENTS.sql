CREATE TABLE [caredata].[HDR_FEED_INGREDIENTS] (
    [ingredient_id]    INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ingredient_name]  VARCHAR (20) NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_HDR_FEED_INGREDIENTS_disabled] DEFAULT ((0)) NOT NULL,
    [system]           BIT          CONSTRAINT [DF_HDR_FEED_INGREDIENTS_system] DEFAULT ((0)) NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_HDR_FEED_INGREDIENTS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_HDR_FEED_INGREDIENTS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_HDR_FEED_INGREDIENTS] PRIMARY KEY NONCLUSTERED ([ingredient_id] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_HDR_FEED_INGREDIENTS_0]
    ON [caredata].[HDR_FEED_INGREDIENTS]([ingredient_name] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 85);

