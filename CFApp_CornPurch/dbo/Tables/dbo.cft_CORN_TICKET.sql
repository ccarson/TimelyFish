CREATE TABLE [dbo].[cft_CORN_TICKET] (
    [TicketID]                   INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TicketNumber]               VARCHAR (20)    NOT NULL,
    [TicketStatusID]             INT             CONSTRAINT [DF_cft_CORN_TICKET_TicketStatusID] DEFAULT (1) NOT NULL,
    [FeedMillID]                 CHAR (10)       NULL,
    [CornProducerID]             VARCHAR (15)    NOT NULL,
    [DeliveryDate]               DATETIME        NULL,
    [SourceFarm]                 VARCHAR (20)    NULL,
    [SourceFarmBin]              VARCHAR (20)    NULL,
    [DestinationFarmBin]         VARCHAR (20)    NULL,
    [Status]                     VARCHAR (20)    NULL,
    [PaymentTypeID]              INT             NULL,
    [Commodity]                  VARCHAR (20)    NULL,
    [CommodityID]                TINYINT         CONSTRAINT [DF_cft_CORN_TICKET_CommodityID] DEFAULT (null) NULL,
    [Moisture]                   DECIMAL (18, 4) NULL,
    [ForeignMaterial]            DECIMAL (18, 4) NULL,
    [OilContent]                 DECIMAL (18, 4) NULL,
    [TestWeight]                 DECIMAL (18, 4) NULL,
    [Gross]                      DECIMAL (18, 4) NULL,
    [Net]                        DECIMAL (18, 4) NULL,
    [Comments]                   VARCHAR (2000)  NULL,
    [ManuallyEntered]            BIT             CONSTRAINT [DF_cft_CORN_TICKET_ManuallyEntered] DEFAULT (0) NULL,
    [SentToDryer]                BIT             NULL,
    [MoistureRateVersion]        INT             NULL,
    [ForeignMaterialRateVersion] INT             NULL,
    [OilContentRateVersion]      INT             NULL,
    [TestWeightRateVersion]      INT             NULL,
    [DryingRateVersion]          INT             NULL,
    [HandlingFeeVersion]         INT             NULL,
    [DeferredPaymentVersion]     INT             NULL,
    [CornCheckOffVersion]        INT             NULL,
    [EthanolCheckOffVersion]     INT             NULL,
    [ShrinkVersion]              INT             NULL,
    [TicketReminderNote]         VARCHAR (2000)  NULL,
    [CornProducerComments]       VARCHAR (2000)  NULL,
    [CreatedDateTime]            DATETIME        CONSTRAINT [DF_cft_CORN_TICKET_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                  VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]            DATETIME        NULL,
    [UpdatedBy]                  VARCHAR (50)    NULL,
    CONSTRAINT [PK_CORN_TICKET] PRIMARY KEY CLUSTERED ([TicketID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CORN_TICKET_cft_COMMODITY] FOREIGN KEY ([CommodityID]) REFERENCES [dbo].[cft_COMMODITY] ([CommodityID]),
    CONSTRAINT [FK_cft_CORN_TICKET_cft_CORN_TICKET] FOREIGN KEY ([TicketStatusID]) REFERENCES [dbo].[cft_CORN_TICKET_STATUS] ([TicketStatusID]),
    CONSTRAINT [FK_cft_CORN_TICKET_cft_CORN_TICKET1] FOREIGN KEY ([TicketID]) REFERENCES [dbo].[cft_CORN_TICKET] ([TicketID])
);


GO
CREATE NONCLUSTERED INDEX [idx_cft_corn_ticket_ticketid_incl]
    ON [dbo].[cft_CORN_TICKET]([TicketID] ASC, [FeedMillID] ASC)
    INCLUDE([Commodity]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_cft_corn_ticket_ticketnumber]
    ON [dbo].[cft_CORN_TICKET]([TicketNumber] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cft_corn_ticket_01]
    ON [dbo].[cft_CORN_TICKET]([FeedMillID] ASC, [CommodityID] ASC)
    INCLUDE([TicketID], [DeliveryDate], [DestinationFarmBin], [TestWeight]) WITH (FILLFACTOR = 90);


GO

CREATE TRIGGER dbo.cftr_History_cft_CORN_TICKET ON dbo.cft_CORN_TICKET
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_CORN_TICKET
  (
       [TicketID]
      ,[TicketNumber]
      ,[TicketStatusID]
      ,[FeedMillID]
      ,[CornProducerID]
      ,[DeliveryDate]
      ,[SourceFarm]
      ,[SourceFarmBin]
      ,[DestinationFarmBin]
      ,[Status]
      ,[PaymentTypeID]
      ,[Commodity]
      ,[CommodityID]
      ,[Moisture]
      ,[ForeignMaterial]
      ,[OilContent]
      ,[TestWeight]
      ,[Gross]
      ,[Net]
      ,[Comments]
      ,[ManuallyEntered]
      ,[SentToDryer]
      ,[MoistureRateVersion]
      ,[ForeignMaterialRateVersion]
      ,[OilContentRateVersion]
      ,[TestWeightRateVersion]
      ,[DryingRateVersion]
      ,[HandlingFeeVersion]
      ,[DeferredPaymentVersion]
      ,[CornCheckOffVersion]
      ,[EthanolCheckOffVersion]
      ,[ShrinkVersion]
      ,[TicketReminderNote]
      ,[CornProducerComments]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  )
  SELECT
       [TicketID]
      ,[TicketNumber]
      ,[TicketStatusID]
      ,[FeedMillID]
      ,[CornProducerID]
      ,[DeliveryDate]
      ,[SourceFarm]
      ,[SourceFarmBin]
      ,[DestinationFarmBin]
      ,[Status]
      ,[PaymentTypeID]
      ,[Commodity]
      ,[CommodityID]
      ,[Moisture]
      ,[ForeignMaterial]
      ,[OilContent]
      ,[TestWeight]
      ,[Gross]
      ,[Net]
      ,[Comments]
      ,[ManuallyEntered]
      ,[SentToDryer]
      ,[MoistureRateVersion]
      ,[ForeignMaterialRateVersion]
      ,[OilContentRateVersion]
      ,[TestWeightRateVersion]
      ,[DryingRateVersion]
      ,[HandlingFeeVersion]
      ,[DeferredPaymentVersion]
      ,[CornCheckOffVersion]
      ,[EthanolCheckOffVersion]
      ,[ShrinkVersion]
      ,[TicketReminderNote]
      ,[CornProducerComments]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Inserted  

END 
  ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM Inserted)
  BEGIN

    SET @RowChangeTypeID = 3	--Delete

    INSERT INTO dbo.cft_AR_CORN_TICKET
    (
       [TicketID]
      ,[TicketNumber]
      ,[TicketStatusID]
      ,[FeedMillID]
      ,[CornProducerID]
      ,[DeliveryDate]
      ,[SourceFarm]
      ,[SourceFarmBin]
      ,[DestinationFarmBin]
      ,[Status]
      ,[PaymentTypeID]
      ,[Commodity]
      ,[CommodityID]
      ,[Moisture]
      ,[ForeignMaterial]
      ,[OilContent]
      ,[TestWeight]
      ,[Gross]
      ,[Net]
      ,[Comments]
      ,[ManuallyEntered]
      ,[SentToDryer]
      ,[MoistureRateVersion]
      ,[ForeignMaterialRateVersion]
      ,[OilContentRateVersion]
      ,[TestWeightRateVersion]
      ,[DryingRateVersion]
      ,[HandlingFeeVersion]
      ,[DeferredPaymentVersion]
      ,[CornCheckOffVersion]
      ,[EthanolCheckOffVersion]
      ,[ShrinkVersion]
      ,[TicketReminderNote]
      ,[CornProducerComments]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [TicketID]
      ,[TicketNumber]
      ,[TicketStatusID]
      ,[FeedMillID]
      ,[CornProducerID]
      ,[DeliveryDate]
      ,[SourceFarm]
      ,[SourceFarmBin]
      ,[DestinationFarmBin]
      ,[Status]
      ,[PaymentTypeID]
      ,[Commodity]
      ,[CommodityID]
      ,[Moisture]
      ,[ForeignMaterial]
      ,[OilContent]
      ,[TestWeight]
      ,[Gross]
      ,[Net]
      ,[Comments]
      ,[ManuallyEntered]
      ,[SentToDryer]
      ,[MoistureRateVersion]
      ,[ForeignMaterialRateVersion]
      ,[OilContentRateVersion]
      ,[TestWeightRateVersion]
      ,[DryingRateVersion]
      ,[HandlingFeeVersion]
      ,[DeferredPaymentVersion]
      ,[CornCheckOffVersion]
      ,[EthanolCheckOffVersion]
      ,[ShrinkVersion]
      ,[TicketReminderNote]
      ,[CornProducerComments]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Deleted

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
      INSERT INTO dbo.cft_AR_CORN_TICKET
  (
       [TicketID]
      ,[TicketNumber]
      ,[TicketStatusID]
      ,[FeedMillID]
      ,[CornProducerID]
      ,[DeliveryDate]
      ,[SourceFarm]
      ,[SourceFarmBin]
      ,[DestinationFarmBin]
      ,[Status]
      ,[PaymentTypeID]
      ,[Commodity]
      ,[CommodityID]
      ,[Moisture]
      ,[ForeignMaterial]
      ,[OilContent]
      ,[TestWeight]
      ,[Gross]
      ,[Net]
      ,[Comments]
      ,[ManuallyEntered]
      ,[SentToDryer]
      ,[MoistureRateVersion]
      ,[ForeignMaterialRateVersion]
      ,[OilContentRateVersion]
      ,[TestWeightRateVersion]
      ,[DryingRateVersion]
      ,[HandlingFeeVersion]
      ,[DeferredPaymentVersion]
      ,[CornCheckOffVersion]
      ,[EthanolCheckOffVersion]
      ,[ShrinkVersion]
      ,[TicketReminderNote]
      ,[CornProducerComments]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,[RowChangeTypeID]  
  )
  SELECT
       [TicketID]
      ,[TicketNumber]
      ,[TicketStatusID]
      ,[FeedMillID]
      ,[CornProducerID]
      ,[DeliveryDate]
      ,[SourceFarm]
      ,[SourceFarmBin]
      ,[DestinationFarmBin]
      ,[Status]
      ,[PaymentTypeID]
      ,[Commodity]
      ,[CommodityID]
      ,[Moisture]
      ,[ForeignMaterial]
      ,[OilContent]
      ,[TestWeight]
      ,[Gross]
      ,[Net]
      ,[Comments]
      ,[ManuallyEntered]
      ,[SentToDryer]
      ,[MoistureRateVersion]
      ,[ForeignMaterialRateVersion]
      ,[OilContentRateVersion]
      ,[TestWeightRateVersion]
      ,[DryingRateVersion]
      ,[HandlingFeeVersion]
      ,[DeferredPaymentVersion]
      ,[CornCheckOffVersion]
      ,[EthanolCheckOffVersion]
      ,[ShrinkVersion]
      ,[TicketReminderNote]
      ,[CornProducerComments]
      ,[CreatedDateTime]
      ,[CreatedBy]
      ,[UpdatedDateTime]
      ,[UpdatedBy]
      ,@RowChangeTypeID
  FROM Inserted  

  END


GO

CREATE TRIGGER [cftr_cft_CORN_TICKET_CORN_PRODUCER_ID] ON [dbo].[cft_CORN_TICKET]
FOR INSERT, UPDATE
AS BEGIN

  SET NOCOUNT ON

  UPDATE dbo.cft_CORN_TICKET
  SET CornProducerID = 'AAAAAA'
  FROM dbo.cft_CORN_TICKET CT
  INNER JOIN Inserted I ON I.TicketID = CT.TicketID
  LEFT OUTER JOIN dbo.cft_CORN_PRODUCER CP ON I.CornProducerID = CP.CornProducerID
  WHERE CP.CornProducerID IS NULL
  
END


GO

CREATE TRIGGER dbo.cftr_cft_CORN_TICKET_DELETE_RELATED ON dbo.cft_CORN_TICKET
FOR UPDATE
AS BEGIN

  SET NOCOUNT ON


--  DELETE dbo.cft_INVENTORY_BATCH 
--  FROM dbo.cft_INVENTORY_BATCH IB
--  INNER JOIN Inserted I ON I.TicketNumber = IB.TicketNumber AND I.TicketStatusID = 2


--  DELETE dbo.cft_SETTLEMENT
--  FROM dbo.cft_SETTLEMENT S
--  INNER JOIN Inserted I ON I.TicketNumber = S.TicketNumber AND I.TicketStatusID = 2


--  DELETE dbo.cft_COMMISSION
--  FROM dbo.cft_COMMISSION COM
--  INNER JOIN dbo.cft_PARTIAL_TICKET PT ON COM.PartialTicketID = PT.PartialTicketID
--  INNER JOIN Inserted I ON I.TicketID = PT.FullTicketID AND I.TicketStatusID = 2  

--  DELETE dbo.cft_COMMISSION_PAYMENT
--  FROM dbo.cft_COMMISSION_PAYMENT COMP
--  INNER JOIN dbo.cft_PARTIAL_TICKET PT ON COMP.PartialTicketID = PT.PartialTicketID
--  INNER JOIN Inserted I ON I.TicketID = PT.FullTicketID AND I.TicketStatusID = 2

  DELETE dbo.cft_PARTIAL_TICKET
  FROM dbo.cft_PARTIAL_TICKET PT
  INNER JOIN Inserted I ON I.TicketID = PT.FullTicketID AND I.TicketStatusID = 2

END
