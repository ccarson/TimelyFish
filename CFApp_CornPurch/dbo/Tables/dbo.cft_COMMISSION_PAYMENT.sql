CREATE TABLE [dbo].[cft_COMMISSION_PAYMENT] (
    [PartialTicketID]        INT             NOT NULL,
    [MarketerID]             TINYINT         NOT NULL,
    [MarketerPercent]        DECIMAL (18, 4) NOT NULL,
    [CommissionRateTypeID]   INT             NOT NULL,
    [CommissionRate]         DECIMAL (20, 6) NOT NULL,
    [MarketerDryBushels]     DECIMAL (20, 6) NOT NULL,
    [CreatedDateTime]        DATETIME        CONSTRAINT [DF_cft_COMMISSION_PAYMENT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]        DATETIME        NULL,
    [UpdatedBy]              VARCHAR (50)    NULL,
    [CornProducerID]         CHAR (15)       NOT NULL,
    [TicketNumber]           VARCHAR (100)   NOT NULL,
    [TotalCommissionPayment] DECIMAL (20, 6) NULL,
    [FeedMillID]             CHAR (10)       NOT NULL,
    [DeliveryDate]           DATETIME        NOT NULL,
    [ContractNumber]         VARCHAR (100)   NULL,
    CONSTRAINT [PK_cft_COMMISSION_PAYMENT] PRIMARY KEY CLUSTERED ([PartialTicketID] ASC, [MarketerID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_COMMISSION_PAYMENT_cft_COMMISSION_RATE_TYPE] FOREIGN KEY ([CommissionRateTypeID]) REFERENCES [dbo].[cft_COMMISSION_RATE_TYPE] ([CommissionRateTypeID]),
    CONSTRAINT [FK_cft_COMMISSION_PAYMENT_cft_MARKETER] FOREIGN KEY ([MarketerID]) REFERENCES [dbo].[cft_MARKETER] ([MarketerID]),
    CONSTRAINT [FK_cft_COMMISSION_PAYMENT_cft_PARTIAL_TICKET] FOREIGN KEY ([PartialTicketID]) REFERENCES [dbo].[cft_PARTIAL_TICKET] ([PartialTicketID]) ON DELETE CASCADE
);

