CREATE TABLE [caredata].[FEED_INVOICES] (
    [invoice_id]       INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [invoice_number]   VARCHAR (20) NULL,
    [order_id]         INT          NOT NULL,
    [payment]          FLOAT (53)   NOT NULL,
    [paid_on]          DATETIME     NULL,
    [check_number]     VARCHAR (20) NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_FEED_INVOICES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_FEED_INVOICES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_FEED_INVOICES] PRIMARY KEY CLUSTERED ([invoice_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FEED_INVOICES_FEED_ORDERS_0] FOREIGN KEY ([order_id]) REFERENCES [caredata].[FEED_ORDERS] ([order_id]) ON DELETE CASCADE
);

