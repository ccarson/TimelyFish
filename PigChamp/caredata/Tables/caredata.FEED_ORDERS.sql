CREATE TABLE [caredata].[FEED_ORDERS] (
    [order_id]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [order_number]     VARCHAR (20)  NULL,
    [site_id]          INT           NOT NULL,
    [ration_id]        INT           NOT NULL,
    [order_date]       DATETIME      NOT NULL,
    [delivery_date]    DATETIME      NOT NULL,
    [feed_id]          INT           NULL,
    [supervisor_id]    INT           NULL,
    [manually_closed]  BIT           CONSTRAINT [DF_FEED_ORDERS_manually_closed] DEFAULT ((0)) NOT NULL,
    [comments]         VARCHAR (300) NULL,
    [quick_entry]      BIT           CONSTRAINT [DF_FEED_ORDERS_quick_entry] DEFAULT ((0)) NOT NULL,
    [creation_date]    DATETIME      CONSTRAINT [DF_FEED_ORDERS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15)  CONSTRAINT [DF_FEED_ORDERS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME      NULL,
    [last_update_by]   VARCHAR (15)  NULL,
    [deletion_date]    DATETIME      NULL,
    [deleted_by]       VARCHAR (15)  NULL,
    CONSTRAINT [PK_FEED_ORDERS] PRIMARY KEY CLUSTERED ([order_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FEED_ORDERS_FEED_COMPANIES_2] FOREIGN KEY ([feed_id]) REFERENCES [caredata].[FEED_COMPANIES] ([feed_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_FEED_ORDERS_HDR_FEED_RATIONS_1] FOREIGN KEY ([ration_id]) REFERENCES [caredata].[HDR_FEED_RATIONS] ([ration_id]),
    CONSTRAINT [FK_FEED_ORDERS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]),
    CONSTRAINT [FK_FEED_ORDERS_SUPERVISORS_3] FOREIGN KEY ([supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_FEED_ORDERS_0]
    ON [caredata].[FEED_ORDERS]([supervisor_id] ASC) WITH (FILLFACTOR = 90);

