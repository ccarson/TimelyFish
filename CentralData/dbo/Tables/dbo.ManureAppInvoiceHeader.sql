CREATE TABLE [dbo].[ManureAppInvoiceHeader] (
    [ManureAppInvoiceHeaderID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureApplicationPlanID]  INT          NULL,
    [ContactID]                INT          NULL,
    [InvoiceNbr]               VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureAppInvoiceHeader] PRIMARY KEY CLUSTERED ([ManureAppInvoiceHeaderID] ASC) WITH (FILLFACTOR = 90)
);

