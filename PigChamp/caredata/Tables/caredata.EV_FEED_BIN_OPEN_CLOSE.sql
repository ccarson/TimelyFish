CREATE TABLE [caredata].[EV_FEED_BIN_OPEN_CLOSE] (
    [event_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [bin_id]           INT          NOT NULL,
    [event_date]       DATETIME     NOT NULL,
    [is_closed]        BIT          NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_FEED_BIN_OPEN_CLOSE_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_FEED_BIN_OPEN_CLOSE_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_FEED_BIN_OPEN_CLOSE] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_FEED_BIN_OPEN_CLOSE_HDR_FEED_BINS_0] FOREIGN KEY ([bin_id]) REFERENCES [caredata].[HDR_FEED_BINS] ([bin_id]) ON DELETE CASCADE
);

