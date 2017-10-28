CREATE TABLE [dbo].[cft_CONTRACT] (
    [ContractID]             INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FeedMillID]             CHAR (10)       NOT NULL,
    [CornProducerID]         VARCHAR (30)    NOT NULL,
    [ContractNumber]         AS              (case when ([SubsequenceNumber] is null) then (rtrim([FeedMillID]) + '-' + convert(varchar,[SequenceNumber])) else (rtrim([FeedMillID]) + '-' + convert(varchar,[SequenceNumber]) + '-' + convert(varchar,[SubsequenceNumber])) end),
    [SequenceNumber]         INT             NOT NULL,
    [SubsequenceNumber]      TINYINT         NULL,
    [CommodityID]            TINYINT         NOT NULL,
    [Priority]               INT             NULL,
    [DateEstablished]        SMALLDATETIME   NOT NULL,
    [DueDateFrom]            SMALLDATETIME   NOT NULL,
    [DueDateTo]              SMALLDATETIME   NOT NULL,
    [Bushels]                DECIMAL (18, 4) NOT NULL,
    [Cash]                   MONEY           NULL,
    [Premium_Deduct]         MONEY           NOT NULL,
    [PricedBasis]            MONEY           NULL,
    [FuturesBasis]           MONEY           NULL,
    [Comments]               VARCHAR (60)    NULL,
    [PayToCornProducerID]    VARCHAR (15)    NULL,
    [Returned]               BIT             NOT NULL,
    [ContractStatusID]       TINYINT         NOT NULL,
    [ContractTypeID]         TINYINT         NOT NULL,
    [Futures]                MONEY           NULL,
    [BasisYear]              SMALLINT        NULL,
    [BasisMonth]             TINYINT         NULL,
    [FuturesYear]            SMALLINT        NULL,
    [FuturesMonth]           TINYINT         NULL,
    [CRMContractID]          VARCHAR (10)    NULL,
    [_RowVersion]            INT             CONSTRAINT [DF_cft_CONTRACT__RowVersion] DEFAULT (1) NOT NULL,
    [CreatedDateTime]        DATETIME        CONSTRAINT [DF_cft_CONTRACT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]        DATETIME        NULL,
    [UpdatedBy]              VARCHAR (50)    NULL,
    [ChangeReasonID]         TINYINT         NULL,
    [ContractAdjustment]     MONEY           NULL,
    [SettlementDate]         DATETIME        NULL,
    [Offer]                  MONEY           NULL,
    [DeferredPaymentDate]    DATETIME        NULL,
    [LastContractTypeID]     INT             NULL,
    [ContractTypeChangeDate] DATETIME        NULL,
    [OriginalContractNumber] VARCHAR (50)    NULL,
    [DeliveryMonth]          AS              (datepart(year,[DueDateFrom]) * 100 + datepart(month,[DueDateFrom])),
    [PricingStartDate]       SMALLDATETIME   NULL,
    [HTAContract]            BIT             NULL,
    [SubProducerName]        VARCHAR (30)    NULL,
    CONSTRAINT [PK_cft_CONTRACT] PRIMARY KEY CLUSTERED ([ContractID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTRACT_cft_CONTRACT_STATUS] FOREIGN KEY ([ContractStatusID]) REFERENCES [dbo].[cft_CONTRACT_STATUS] ([ContractStatusID]),
    CONSTRAINT [FK_cft_CONTRACT_cft_CONTRACT_TYPE] FOREIGN KEY ([ContractTypeID]) REFERENCES [dbo].[cft_CONTRACT_TYPE] ([ContractTypeID]),
    CONSTRAINT [FK_cft_CONTRACT_cft_FEED_MILL] FOREIGN KEY ([FeedMillID]) REFERENCES [dbo].[cft_FEED_MILL] ([FeedMillID]),
    CONSTRAINT [FK_cft_CONTRACT_cft_FINANCIAL_MONTH] FOREIGN KEY ([BasisMonth]) REFERENCES [dbo].[cft_FINANCIAL_MONTH] ([FinancialMonthID]),
    CONSTRAINT [FK_cft_CONTRACT_cft_FINANCIAL_MONTH1] FOREIGN KEY ([FuturesMonth]) REFERENCES [dbo].[cft_FINANCIAL_MONTH] ([FinancialMonthID]),
    CONSTRAINT [FK_cft_CONTRACT_cft_ROW_CHANGE_REASON] FOREIGN KEY ([ChangeReasonID]) REFERENCES [dbo].[cft_ROW_CHANGE_REASON] ([ChangeReasonID])
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_CONTRACT_CommodityID_DeliveryMonth]
    ON [dbo].[cft_CONTRACT]([CommodityID] ASC, [DeliveryMonth] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_cft_CONTRACT_feedmill_plus2_incl]
    ON [dbo].[cft_CONTRACT]([FeedMillID] ASC, [SequenceNumber] ASC, [ContractStatusID] ASC)
    INCLUDE([Bushels]) WITH (FILLFACTOR = 90);


GO

CREATE TRIGGER dbo.cftr_cft_CONTRACT_CONTRACT_ADJUSTMENT_RATE ON dbo.cft_CONTRACT
FOR UPDATE
AS
SET NOCOUNT ON


IF UPDATE(ContractAdjustment) BEGIN

  UPDATE dbo.cft_PARTIAL_TICKET
  SET ContractAdjustmentRate = I.ContractAdjustment
  FROM Inserted I
  INNER JOIN dbo.cft_PARTIAL_TICKET PT ON I.ContractID = PT.ContractID
  WHERE ISNULL(PT.SentToAccountsPayable, 0) <> 1

END 


GO

CREATE TRIGGER [dbo].[cftr_History_cft_CONTRACT] ON [dbo].[cft_CONTRACT]
FOR INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON

DECLARE @RowChangeTypeID tinyint

IF NOT EXISTS (SELECT TOP 1 1 FROM Deleted)
BEGIN

  SET @RowChangeTypeID = 1	--Insert

  INSERT INTO dbo.cft_AR_CONTRACT
  (
      ContractID,
      FeedMillID,
      CornProducerID,
      ContractNumber,
      SequenceNumber,
      SubsequenceNumber,
      CommodityID,
      Priority,
      DateEstablished,
	  PricingStartDate,
      DueDateFrom,
      DueDateTo,
      Bushels,
      Cash,
      Premium_Deduct,
      PricedBasis,
      FuturesBasis,
      Comments,
      PayToCornProducerID,
      Returned,
      ContractStatusID,
      ContractTypeID,
      Futures,
      BasisYear,
      BasisMonth,
      FuturesYear,
      FuturesMonth,
      CRMContractID,
      _RowVersion,
      ChangeReasonID,
      ContractAdjustment,
      SettlementDate,
      Offer,
      DeferredPaymentDate,
      LastContractTypeID,
      ContractTypeChangeDate,
      RowChangeTypeID,
      CreatedDateTime,
      CreatedBy,
      UpdatedDateTime,
      UpdatedBy,
      OriginalContractNumber
  )
  SELECT
      ContractID,
      FeedMillID,
      CornProducerID,
      ContractNumber,
      SequenceNumber,
      SubsequenceNumber,
      CommodityID,
      Priority,
      DateEstablished,
	  PricingStartDate,
      DueDateFrom,
      DueDateTo,
      Bushels,
      Cash,
      Premium_Deduct,
      PricedBasis,
      FuturesBasis,
      Comments,
      PayToCornProducerID,
      Returned,
      ContractStatusID,
      ContractTypeID,
      Futures,
      BasisYear,
      BasisMonth,
      FuturesYear,
      FuturesMonth,
      CRMContractID,
      _RowVersion,
      ChangeReasonID,
      ContractAdjustment,
      SettlementDate,
      Offer,
      DeferredPaymentDate,
      LastContractTypeID,
      ContractTypeChangeDate,
      @RowChangeTypeID,
      CreatedDateTime,
      CreatedBy,
      UpdatedDateTime,
      UpdatedBy,
      OriginalContractNumber
  FROM Inserted  

END 
  ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM Inserted)
  BEGIN

    SET @RowChangeTypeID = 3	--Delete

    INSERT INTO dbo.cft_AR_CONTRACT
    (
        ContractID,
        FeedMillID,
        CornProducerID,
        ContractNumber,
        SequenceNumber,
        SubsequenceNumber,
        CommodityID,
        Priority,
        DateEstablished,
        PricingStartDate,
        DueDateFrom,
        DueDateTo,
        Bushels,
        Cash,
        Premium_Deduct,
        PricedBasis,
        FuturesBasis,
        Comments,
        PayToCornProducerID,
        Returned,
        ContractStatusID,
        ContractTypeID,
        Futures,
        BasisYear,
        BasisMonth,
        FuturesYear,
        FuturesMonth,
        CRMContractID,
        _RowVersion,
        ChangeReasonID,
        ContractAdjustment,
        SettlementDate,
        Offer,
        DeferredPaymentDate,
        LastContractTypeID,
        ContractTypeChangeDate,
        RowChangeTypeID,
        CreatedDateTime,
        CreatedBy,
        UpdatedDateTime,
        UpdatedBy,
        OriginalContractNumber
  )
  SELECT
        ContractID,
        FeedMillID,
        CornProducerID,
        ContractNumber,
        SequenceNumber,
        SubsequenceNumber,
        CommodityID,
        Priority,
        DateEstablished,
        PricingStartDate,
        DueDateFrom,
        DueDateTo,
        Bushels,
        Cash,
        Premium_Deduct,
        PricedBasis,
        FuturesBasis,
        Comments,
        PayToCornProducerID,
        Returned,
        ContractStatusID,
        ContractTypeID,
        Futures,
        BasisYear,
        BasisMonth,
        FuturesYear,
        FuturesMonth,
        CRMContractID,
        _RowVersion,
        ChangeReasonID,
        ContractAdjustment,
        SettlementDate,
        Offer,
        DeferredPaymentDate,
        LastContractTypeID,
        ContractTypeChangeDate,
        @RowChangeTypeID,
        CreatedDateTime,
        CreatedBy,
        UpdatedDateTime,
        UpdatedBy,
        OriginalContractNumber
  FROM Deleted

  END ELSE BEGIN

    SET @RowChangeTypeID = 2	--Update
    
      INSERT INTO dbo.cft_AR_CONTRACT
  (
      ContractID,
      FeedMillID,
      CornProducerID,
      ContractNumber,
      SequenceNumber,
      SubsequenceNumber,
      CommodityID,
      Priority,
      DateEstablished,
      PricingStartDate,
      DueDateFrom,
      DueDateTo,
      Bushels,
      Cash,
      Premium_Deduct,
      PricedBasis,
      FuturesBasis,
      Comments,
      PayToCornProducerID,
      Returned,
      ContractStatusID,
      ContractTypeID,
      Futures,
      BasisYear,
      BasisMonth,
      FuturesYear,
      FuturesMonth,
      CRMContractID,
      _RowVersion,
      ChangeReasonID,
      ContractAdjustment,
      SettlementDate,
      Offer,
      DeferredPaymentDate,
      LastContractTypeID,
      ContractTypeChangeDate,
      RowChangeTypeID,
      CreatedDateTime,
      CreatedBy,
      UpdatedDateTime,
      UpdatedBy,
      OriginalContractNumber
  )
  SELECT
      ContractID,
      FeedMillID,
      CornProducerID,
      ContractNumber,
      SequenceNumber,
      SubsequenceNumber,
      CommodityID,
      Priority,
      DateEstablished,
      PricingStartDate,
      DueDateFrom,
      DueDateTo,
      Bushels,
      Cash,
      Premium_Deduct,
      PricedBasis,
      FuturesBasis,
      Comments,
      PayToCornProducerID,
      Returned,
      ContractStatusID,
      ContractTypeID,
      Futures,
      BasisYear,
      BasisMonth,
      FuturesYear,
      FuturesMonth,
      CRMContractID,
      _RowVersion,
      ChangeReasonID,
      ContractAdjustment,
      SettlementDate,
      Offer,
      DeferredPaymentDate,
      LastContractTypeID,
      ContractTypeChangeDate,
      @RowChangeTypeID,
      CreatedDateTime,
      CreatedBy,
      UpdatedDateTime,
      UpdatedBy,
      OriginalContractNumber
  FROM Inserted  

  END

