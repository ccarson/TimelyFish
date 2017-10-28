CREATE TABLE [dbo].[cft_UNSETTLED_DRYING_CHARGE] (
    [CornProducerID]      VARCHAR (15)    NOT NULL,
    [CornProducerName]    VARCHAR (30)    NULL,
    [DeliveryDate]        DATETIME        NULL,
    [DryingChargesAmount] DECIMAL (18, 4) NULL,
    [TicketNumber]        VARCHAR (20)    NULL,
    [WetBushels]          DECIMAL (18, 4) NULL
);

