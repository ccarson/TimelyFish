CREATE TABLE [dbo].[cft_SETTLEMENT] (
    [SettlementID]                      INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TicketNumber]                      VARCHAR (20)    NOT NULL,
    [PayTo_VendorID]                    VARCHAR (15)    NULL,
    [Delivery_VendorID]                 VARCHAR (15)    NULL,
    [ContractNumber]                    VARCHAR (72)    NULL,
    [ActualPricePerBushel]              DECIMAL (18, 4) NULL,
    [CashPricePerBushel]                DECIMAL (18, 4) NULL,
    [ContractAdjustmentAmount]          DECIMAL (18, 4) NULL,
    [MoistureValuationMethodScheduleID] INT             NULL,
    [MoistureDeductionAmount]           DECIMAL (18, 4) NULL,
    [MoistureScheduleID]                INT             NULL,
    [DryingChargesAmount]               DECIMAL (18, 4) NULL,
    [DryingChargesScheduleID]           INT             NULL,
    [ShrinkScheduleID]                  INT             NULL,
    [TestWeightAmount]                  DECIMAL (18, 4) NULL,
    [TestWeightScheduleID]              INT             NULL,
    [ForeignMaterialAmount]             DECIMAL (18, 4) NULL,
    [ForeignMaterialScheduleID]         INT             NULL,
    [CornCheckoffAmount]                DECIMAL (18, 4) NULL,
    [EthanolCheckoffAmount]             DECIMAL (18, 4) NULL,
    [HandlingAmount]                    DECIMAL (18, 4) NULL,
    [HandlingScheduleID]                INT             NULL,
    [DeferredPaymentAmount]             DECIMAL (18, 4) NULL,
    [DeferredPaymentScheduleID]         INT             NULL,
    [DelayedCornPricingVarianceAmount]  DECIMAL (18, 4) NULL,
    [PurchaseCornOptionsAmount]         DECIMAL (18, 4) NULL,
    [MiscellaneousAdjustmentAmount]     DECIMAL (18, 4) NULL,
    [FSAPaymentAmt]                     DECIMAL (18, 4) NULL,
    [CheckNumber]                       VARCHAR (10)    NULL,
    [APBatchNumber]                     VARCHAR (10)    NULL,
    [MoistureMethod]                    INT             NULL,
    [CornClearingAmount]                DECIMAL (18, 4) NULL,
    [MarketVariance]                    DECIMAL (18, 4) NULL,
    [AccountsPayableBatchType]          INT             NULL,
    [FSALoanNumber]                     VARCHAR (100)   NULL,
    [HandlingStartDate]                 SMALLDATETIME   NULL,
    [DeferredStartDate]                 SMALLDATETIME   NULL,
    [NetPaymentPerBushel]               DECIMAL (18, 4) DEFAULT (0) NOT NULL,
    [PartialTicketID]                   INT             NULL,
    [PaymentDate]                       DATETIME        CONSTRAINT [DF_cft_SETTLEMENT_PaymentDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SettlementTable] PRIMARY KEY CLUSTERED ([SettlementID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_DEFERRED_PAYMENT] FOREIGN KEY ([DeferredPaymentScheduleID]) REFERENCES [dbo].[cft_GPA_DEFERRED_PAYMENT] ([GPADeferredPaymentID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_DRYING_CHARGE_DETAIL] FOREIGN KEY ([DryingChargesScheduleID]) REFERENCES [dbo].[cft_GPA_DRYING_CHARGE] ([GPADryingChargeID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_FOREIGN_MATERIAL_DETAIL] FOREIGN KEY ([ForeignMaterialScheduleID]) REFERENCES [dbo].[cft_GPA_FOREIGN_MATERIAL] ([GPAForeignMaterialID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_HANDLING_CHARGE] FOREIGN KEY ([HandlingScheduleID]) REFERENCES [dbo].[cft_GPA_HANDLING_CHARGE] ([GPAHandlingChargeID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_MOISTURE_CHARGE_DETAIL] FOREIGN KEY ([MoistureScheduleID]) REFERENCES [dbo].[cft_GPA_MOISTURE_CHARGE] ([GPAMoistureChargeID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_MOISTURE_VALUATION_METHOD] FOREIGN KEY ([MoistureMethod]) REFERENCES [dbo].[cft_GPA_MOISTURE_VALUATION_METHOD] ([GPAMoistureValuationMethodID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_MOISTURE_VALUATION_METHOD_SCHEDULE] FOREIGN KEY ([MoistureValuationMethodScheduleID]) REFERENCES [dbo].[cft_GPA_MOISTURE_VALUATION] ([GPAMoistureValuationID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_SHRINK_DEDUCTION_DETAIL] FOREIGN KEY ([ShrinkScheduleID]) REFERENCES [dbo].[cft_GPA_SHRINK_DEDUCTION] ([GPAShrinkDeductionID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_GPA_TEST_WEIGHT_DETAIL] FOREIGN KEY ([TestWeightScheduleID]) REFERENCES [dbo].[cft_GPA_TEST_WEIGHT] ([GPATestWeightID]),
    CONSTRAINT [FK_cft_SETTLEMENT_cft_PARTIAL_TICKET] FOREIGN KEY ([PartialTicketID]) REFERENCES [dbo].[cft_PARTIAL_TICKET] ([PartialTicketID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_SETTLEMENT_APBatchNumber]
    ON [dbo].[cft_SETTLEMENT]([APBatchNumber] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_SETTLEMENT_PayTo_VendorID]
    ON [dbo].[cft_SETTLEMENT]([PayTo_VendorID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_SETTLEMENT_MasterSettlementCover]
    ON [dbo].[cft_SETTLEMENT]([APBatchNumber] ASC, [Delivery_VendorID] ASC, [PayTo_VendorID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_SETTLEMENT_ContractNumber]
    ON [dbo].[cft_SETTLEMENT]([ContractNumber] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_cft_SETTLEMENT_Delivery_VendorID]
    ON [dbo].[cft_SETTLEMENT]([Delivery_VendorID] ASC) WITH (FILLFACTOR = 90);


GO
-- =============================================
-- Author:		Matt Dawson
-- Create date: 09-26-2008
-- Description:	Creates a MasterSettlement entry 
--	if one doesn't exist in relation to the APBatchNumber and Delivery_VendorID
-- =============================================
CREATE TRIGGER  dbo.cftr_INSERT_cft_MasterSettlement_FROM_cft_Settlement
   ON  dbo.cft_Settlement 
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO dbo.cft_MASTER_SETTLEMENT (MasterSettlementID, APBatchNumber, Delivery_VendorID, PayTo_VendorID)
	SELECT	RTRIM(ct.FeedMillID) + '-' + CAST(cast(COALESCE(NextEnum.MaxID,0) as bigint) + 1 AS VARCHAR)
	,	APBatchNumber
	,	Delivery_VendorID
	,	PayTo_VendorID
	from Inserted s (NOLOCK)
	INNER JOIN dbo.cft_Partial_Ticket pt (NOLOCK)
		ON pt.PartialTicketID = s.PartialTicketID
	INNER JOIN dbo.cft_Corn_Ticket ct (NOLOCK)
		ON ct.TicketID = pt.FullTicketID
	LEFT OUTER JOIN (SELECT LEFT(ms.MasterSettlementID,CHARINDEX('-',ms.MasterSettlementID) - 1) 'FeedMillID'
				,MAX(cast(RIGHT(ms.MasterSettlementID,LEN(ms.MasterSettlementID) - CHARINDEX('-',ms.MasterSettlementID)) as bigint)) 'MaxID' 
			FROM dbo.cft_Master_Settlement ms (NOLOCK)
			GROUP BY LEFT(ms.MasterSettlementID,CHARINDEX('-',ms.MasterSettlementID) - 1)) NextEnum
		ON NextEnum.FeedMillID = RTRIM(ct.FeedMillID)
	WHERE NOT EXISTS
		(SELECT * FROM dbo.cft_Master_Settlement WHERE RTRIM(APBatchnumber) = RTRIM(s.APBatchNumber) AND RTRIM(Delivery_VendorID) = RTRIM(s.Delivery_VendorID) AND RTRIM(PayTo_VendorID) = RTRIM(s.PayTo_VendorID))
	


END
