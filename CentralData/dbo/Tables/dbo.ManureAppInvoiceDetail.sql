CREATE TABLE [dbo].[ManureAppInvoiceDetail] (
    [ManureAppInvoiceDetailID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureAppInvoiceHeaderID]   INT          NULL,
    [ManureAppDetailTypeID]      INT          NULL,
    [ManureAppDetailSubTypeID]   INT          NULL,
    [ManureAppDetailDescription] VARCHAR (30) NULL,
    [ManureAppRateTypeID]        INT          NULL,
    [ManureAppRate]              FLOAT (53)   NULL,
    [ManureAppDetailQty]         FLOAT (53)   NULL,
    [BillableFlag]               SMALLINT     CONSTRAINT [DF_ManureAppInvoiceDetail_BillableFlag] DEFAULT ((-1)) NULL,
    CONSTRAINT [PK_ManureApplicationFirmInvoiceDetail] PRIMARY KEY CLUSTERED ([ManureAppInvoiceDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ManureAppInvoiceDetail_ManureAppInvoiceHeader] FOREIGN KEY ([ManureAppInvoiceHeaderID]) REFERENCES [dbo].[ManureAppInvoiceHeader] ([ManureAppInvoiceHeaderID]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Header/Type]
    ON [dbo].[ManureAppInvoiceDetail]([ManureAppInvoiceHeaderID] ASC, [ManureAppDetailTypeID] ASC, [ManureAppInvoiceDetailID] ASC) WITH (FILLFACTOR = 90);

