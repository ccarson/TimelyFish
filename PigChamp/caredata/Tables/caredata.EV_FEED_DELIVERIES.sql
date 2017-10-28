CREATE TABLE [caredata].[EV_FEED_DELIVERIES] (
    [event_id]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [order_id]         INT          NULL,
    [transfer_id]      INT          NULL,
    [bin_id]           INT          NOT NULL,
    [transport_id]     INT          NULL,
    [delivery_date]    DATETIME     NOT NULL,
    [qty_delivered]    FLOAT (53)   NOT NULL,
    [excess_inventory] FLOAT (53)   NOT NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_FEED_DELIVERIES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_FEED_DELIVERIES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_FEED_DELIVERIES] PRIMARY KEY NONCLUSTERED ([event_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_FEED_DELIVERIES_EV_FEED_TRANSFERS_1] FOREIGN KEY ([transfer_id]) REFERENCES [caredata].[EV_FEED_TRANSFERS] ([event_id]),
    CONSTRAINT [FK_EV_FEED_DELIVERIES_FEED_ORDERS_0] FOREIGN KEY ([order_id]) REFERENCES [caredata].[FEED_ORDERS] ([order_id]) ON DELETE SET NULL,
    CONSTRAINT [FK_EV_FEED_DELIVERIES_HDR_FEED_BINS_2] FOREIGN KEY ([bin_id]) REFERENCES [caredata].[HDR_FEED_BINS] ([bin_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_FEED_DELIVERIES_TRANSPORT_COMPANIES_3] FOREIGN KEY ([transport_id]) REFERENCES [caredata].[TRANSPORT_COMPANIES] ([transport_id]) ON UPDATE CASCADE
);

