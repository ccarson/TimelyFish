CREATE TABLE [careimport].[IMPORT_FEED_DELIVERY] (
    [row_id]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [import_id]      INT           NOT NULL,
    [delivery_date]  DATETIME      NULL,
    [ration_name]    VARCHAR (20)  NULL,
    [bin_name]       VARCHAR (30)  NULL,
    [quantity]       FLOAT (53)    NULL,
    [amount]         FLOAT (53)    NULL,
    [feed_mill]      VARCHAR (30)  NULL,
    [order_date]     DATETIME      NULL,
    [order_number]   VARCHAR (20)  NULL,
    [invoice_number] VARCHAR (20)  NULL,
    [comments]       VARCHAR (200) NULL,
    [process_date]   DATETIME      NULL,
    [error_date]     DATETIME      NULL,
    [error_code]     SMALLINT      NULL,
    [error_message]  VARCHAR (250) NULL,
    CONSTRAINT [PK_IMPORT_FEED_DELIVERY] PRIMARY KEY CLUSTERED ([row_id] ASC) WITH (FILLFACTOR = 90)
);

