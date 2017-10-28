CREATE TABLE [dbo].[cft_PARTIAL_TICKET] (
    [PartialTicketID]        INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TicketNumber]           VARCHAR (20)    NOT NULL,
    [FullTicketID]           INT             NOT NULL,
    [ContractID]             INT             NULL,
    [DeliveryDate]           DATETIME        NOT NULL,
    [DryBushels]             DECIMAL (18, 4) NOT NULL,
    [MoistureRateAdj]        MONEY           NULL,
    [ForeignMaterialRateAdj] MONEY           NULL,
    [TestWeightRateAdj]      MONEY           NULL,
    [DryingRateAdj]          MONEY           NULL,
    [HandlingRateAdj]        MONEY           NULL,
    [DeferredPaymentRateAdj] MONEY           NULL,
    [MiscAdj]                MONEY           NULL,
    [MiscAdjNote]            VARCHAR (60)    NULL,
    [ContractAdjustmentRate] MONEY           NULL,
    [PaymentTypeID]          INT             NULL,
    [QuoteID]                INT             NULL,
    [PaymentTermsID]         CHAR (2)        NULL,
    [TicketAdjNote]          VARCHAR (1000)  NULL,
    [CornProducerID]         VARCHAR (15)    NOT NULL,
    [ReadyToBeReleased]      BIT             NOT NULL,
    [CreatedDateTime]        DATETIME        CONSTRAINT [DF_cft_PARTIAL_TICKET_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]        DATETIME        NULL,
    [UpdatedBy]              VARCHAR (50)    NULL,
    [DeliveryCornProducerID] VARCHAR (15)    NULL,
    [PartialTicketStatusID]  INT             CONSTRAINT [DF_cft_PARTIAL_TICKET_PartialTicketStatusID] DEFAULT (1) NOT NULL,
    [SentToInventory]        BIT             CONSTRAINT [DF_cft_PARTIAL_TICKET_SentToInventory] DEFAULT (0) NOT NULL,
    [SentToAccountsPayable]  BIT             CONSTRAINT [DF_cft_PARTIAL_TICKET_SentToAccountsPayable] DEFAULT (0) NOT NULL,
    [WetBushels]             DECIMAL (20, 4) DEFAULT (0) NOT NULL,
    [DailyPriceDetailID]     INT             NULL,
    CONSTRAINT [PK_PARTIAL_TICKET] PRIMARY KEY CLUSTERED ([PartialTicketID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_PARTIAL_TICKET_cft_CONTRACT] FOREIGN KEY ([ContractID]) REFERENCES [dbo].[cft_CONTRACT] ([ContractID]),
    CONSTRAINT [FK_cft_PARTIAL_TICKET_cft_CORN_PRODUCER] FOREIGN KEY ([CornProducerID]) REFERENCES [dbo].[cft_CORN_PRODUCER] ([CornProducerID]),
    CONSTRAINT [FK_cft_PARTIAL_TICKET_cft_CORN_PRODUCER1] FOREIGN KEY ([DeliveryCornProducerID]) REFERENCES [dbo].[cft_CORN_PRODUCER] ([CornProducerID]),
    CONSTRAINT [FK_cft_PARTIAL_TICKET_cft_CORN_TICKET] FOREIGN KEY ([FullTicketID]) REFERENCES [dbo].[cft_CORN_TICKET] ([TicketID]),
    CONSTRAINT [FK_cft_PARTIAL_TICKET_cft_QUOTE] FOREIGN KEY ([QuoteID]) REFERENCES [dbo].[cft_QUOTE] ([QuoteID]),
    CONSTRAINT [FK_cft_PARTIAL_TICKET_cft_TICKET_PAYMENT_TYPE] FOREIGN KEY ([PaymentTypeID]) REFERENCES [dbo].[cft_TICKET_PAYMENT_TYPE] ([PaymentTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_PARTIAL_TICKET_FullTicketID]
    ON [dbo].[cft_PARTIAL_TICKET]([FullTicketID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_PARTIAL_TICKET_ContractID]
    ON [dbo].[cft_PARTIAL_TICKET]([ContractID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_CFT_PARTIAL_TICKET_DeliveryDate]
    ON [dbo].[cft_PARTIAL_TICKET]([DeliveryDate] ASC, [SentToAccountsPayable] ASC)
    INCLUDE([FullTicketID], [ContractID], [DryBushels], [PaymentTypeID], [QuoteID], [CornProducerID]);


GO
CREATE NONCLUSTERED INDEX [IX_cft_PARTIAL_TICKET_QuoteID]
    ON [dbo].[cft_PARTIAL_TICKET]([QuoteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_PARTIAL_TICKET_CornProducerID]
    ON [dbo].[cft_PARTIAL_TICKET]([CornProducerID] ASC) WITH (FILLFACTOR = 90);


GO

CREATE TRIGGER dbo.cftr_History_cft_PARTIAL_TICKET ON dbo.cft_PARTIAL_TICKET
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_PARTIAL_TICKET
  (
       [PartialTicketID]
      ,[TicketNumber]
      ,[FullTicketID]
      ,[ContractID]
      ,[DeliveryDate]
      ,[DryBushels]
      ,[MoistureRateAdj]
      ,[ForeignMaterialRateAdj]
      ,[TestWeightRateAdj]
      ,[DryingRateAdj]
      ,[HandlingRateAdj]
      ,[DeferredPaymentRateAdj]
      ,[MiscAdj]
      ,[MiscAdjNote]
      ,[ContractAdjustmentRate]
      ,[PaymentTypeID]
      ,[QuoteID]
      ,[PaymentTermsID]
      ,[TicketAdjNote]
      ,[CornProducerID]
      ,[DeliveryCornProducerID]
      ,[ReadyToBeReleased]
      ,[PartialTicketStatusID]
      ,[SentToInventory]
      ,[SentToAccountsPayable]
      ,[WetBushels]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]
      ,[DailyPriceDetailID]
  )
  SELECT
       [PartialTicketID]
      ,[TicketNumber]
      ,[FullTicketID]
      ,[ContractID]
      ,[DeliveryDate]
      ,[DryBushels]
      ,[MoistureRateAdj]
      ,[ForeignMaterialRateAdj]
      ,[TestWeightRateAdj]
      ,[DryingRateAdj]
      ,[HandlingRateAdj]
      ,[DeferredPaymentRateAdj]
      ,[MiscAdj]
      ,[MiscAdjNote]
      ,[ContractAdjustmentRate]
      ,[PaymentTypeID]
      ,[QuoteID]
      ,[PaymentTermsID]
      ,[TicketAdjNote]
      ,[CornProducerID]
      ,[DeliveryCornProducerID]
      ,[ReadyToBeReleased]
      ,[PartialTicketStatusID]
      ,[SentToInventory]
      ,[SentToAccountsPayable]
      ,[WetBushels]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
      ,[DailyPriceDetailID]
  FROM Inserted  

END 
  ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM Inserted)
  BEGIN

    SET @RowChangeTypeID = 3	--Delete

    INSERT INTO dbo.cft_AR_PARTIAL_TICKET
    (
       [PartialTicketID]
      ,[TicketNumber]
      ,[FullTicketID]
      ,[ContractID]
      ,[DeliveryDate]
      ,[DryBushels]
      ,[MoistureRateAdj]
      ,[ForeignMaterialRateAdj]
      ,[TestWeightRateAdj]
      ,[DryingRateAdj]
      ,[HandlingRateAdj]
      ,[DeferredPaymentRateAdj]
      ,[MiscAdj]
      ,[MiscAdjNote]
      ,[ContractAdjustmentRate]
      ,[PaymentTypeID]
      ,[QuoteID]
      ,[PaymentTermsID]
      ,[TicketAdjNote]
      ,[CornProducerID]
      ,[DeliveryCornProducerID]
      ,[ReadyToBeReleased]
      ,[PartialTicketStatusID]
      ,[SentToInventory]
      ,[SentToAccountsPayable]
      ,[WetBushels]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]
      ,[DailyPriceDetailID]  
  )
  SELECT
       [PartialTicketID]
      ,[TicketNumber]
      ,[FullTicketID]
      ,[ContractID]
      ,[DeliveryDate]
      ,[DryBushels]
      ,[MoistureRateAdj]
      ,[ForeignMaterialRateAdj]
      ,[TestWeightRateAdj]
      ,[DryingRateAdj]
      ,[HandlingRateAdj]
      ,[DeferredPaymentRateAdj]
      ,[MiscAdj]
      ,[MiscAdjNote]
      ,[ContractAdjustmentRate]
      ,[PaymentTypeID]
      ,[QuoteID]
      ,[PaymentTermsID]
      ,[TicketAdjNote]
      ,[CornProducerID]
      ,[DeliveryCornProducerID]
      ,[ReadyToBeReleased]
      ,[PartialTicketStatusID]
      ,[SentToInventory]
      ,[SentToAccountsPayable]
      ,[WetBushels]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
      ,[DailyPriceDetailID]
  FROM Deleted

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
      INSERT INTO dbo.cft_AR_PARTIAL_TICKET
  (
       [PartialTicketID]
      ,[TicketNumber]
      ,[FullTicketID]
      ,[ContractID]
      ,[DeliveryDate]
      ,[DryBushels]
      ,[MoistureRateAdj]
      ,[ForeignMaterialRateAdj]
      ,[TestWeightRateAdj]
      ,[DryingRateAdj]
      ,[HandlingRateAdj]
      ,[DeferredPaymentRateAdj]
      ,[MiscAdj]
      ,[MiscAdjNote]
      ,[ContractAdjustmentRate]
      ,[PaymentTypeID]
      ,[QuoteID]
      ,[PaymentTermsID]
      ,[TicketAdjNote]
      ,[CornProducerID]
      ,[DeliveryCornProducerID]
      ,[ReadyToBeReleased]
      ,[PartialTicketStatusID]
      ,[SentToInventory]
      ,[SentToAccountsPayable]
      ,[WetBushels]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]
      ,[DailyPriceDetailID]  
  )
  SELECT
       [PartialTicketID]
      ,[TicketNumber]
      ,[FullTicketID]
      ,[ContractID]
      ,[DeliveryDate]
      ,[DryBushels]
      ,[MoistureRateAdj]
      ,[ForeignMaterialRateAdj]
      ,[TestWeightRateAdj]
      ,[DryingRateAdj]
      ,[HandlingRateAdj]
      ,[DeferredPaymentRateAdj]
      ,[MiscAdj]
      ,[MiscAdjNote]
      ,[ContractAdjustmentRate]
      ,[PaymentTypeID]
      ,[QuoteID]
      ,[PaymentTermsID]
      ,[TicketAdjNote]
      ,[CornProducerID]
      ,[DeliveryCornProducerID]
      ,[ReadyToBeReleased]
      ,[PartialTicketStatusID]
      ,[SentToInventory]
      ,[SentToAccountsPayable]
      ,[WetBushels]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
      ,[DailyPriceDetailID]
  FROM Inserted  

  END

