

-- =============================================
-- Author:		Sergey Neskin
-- Create date: 09/09/2008
-- Description:	Select data for DCR Report.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_DCR_old]
	@FeedMillID char(10),				-- Feed Mill ID
	@DeliveryDateFrom smalldatetime,	-- Delivery Date From
	@DeliveryDateTo smalldatetime,		-- Delivery Date To
	@ContractTypeID int,			-- Contract Type
	@Price bit,							-- Price (0 - no, 1 - yes)
	@CornProducer varchar(30),			-- Corn Producer
	@Elevator bit,						-- Elevator (0 - no, 1 - yes)
	@DateEstablished smalldatetime,		-- Date Established
	@PurchasePrice float,				-- Purchase Price
	@PurchasePriceMode int,				-- Purchase Price Mode (0 - greater, 1 - less, 2 - equal)
	@PricedBasis float,					-- Priced Basis
	@PricedBasisMode int,				-- Priced Basis Mode (0 - greater, 1 - less, 2 - equal)
	@ContractedBushels int,				-- Contracted Bushels
	@Balance int,						-- Balance
	@BalanceMode int,					-- Balance Mode (0 - greater, 1 - less, 2 - equal)
	@BasisPeriod varchar(5),
	@FuturesPeriod varchar(5),
	@FuturesPrice float,				-- Futures Price
	@FuturesPriceMode int,				-- Futures Price Mode (0 - greater, 1 - less, 2 - equal)
	@Futures float,						-- Futures
	@FuturesMode int,					-- Futures Mode (0 - greater, 1 - less, 2 - equal)
	@Offer float,						-- Offer
	@OfferMode int,						-- Offer Mode (0 - greater, 1 - less, 2 - equal)
	@SettlementDate	varchar(10),			-- Settlement Date
	@CRMContract bit,					-- CRM Contract (0 - no, 1 - yes)
	@ContractStatus char(3),			-- Contract Status ("111" - first '1' - Open, second '1' - Close, third '1' - Void)
	@PremiumDeduct float,				-- Premium / Deduct
	@PremiumDeductMode int				-- Premium / Deduct Mode (0 - greater, 1 - less, 2 - equal)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SQLSelect nvarchar(4000)
	SET @SQLSelect = N'
		SELECT FM.Name AS FeedMillName,				-- Feed Mill Name
			V.RemitName AS CornProducerName,		-- Corn Producer Name
			CP.Elevator AS Elevator,				-- Elevator
			C.ContractNumber AS ContractNumber,		-- Contract Number
			CT.Name AS ContractType,				-- Contract Type
			C.CRMContractID AS CRMContractNumber,	-- CRM Contract Number
			C.DateEstablished AS DateEstablished,	-- Date Established
			CASE 
				WHEN NOT C.SubsequenceNumber IS NULL THEN C.Bushels
				ELSE C.Bushels - dbo.cffn_GET_SUM_CHILD_BUSHELS(C.SequenceNumber, C.FeedMillID)
			END AS ContractedBushels,				-- Contracted Bushels
			C.DueDateFrom AS DeliveryDateFrom,		-- Delivery Date From
			C.DueDateTo AS DeliveryDateTo,			-- Delivery Date To
			C.Cash AS PurchasePrice,				-- Purchase Price
			C.PricedBasis AS PricedBasis,			-- Priced Basis
			C.BasisMonth AS BasisMonth,				-- Basis Month
			C.BasisYear AS BasisYear,				-- Basis Year
			C.FuturesBasis AS FuturesPrice,			-- Futures Price
			C.FuturesMonth AS FuturesMonth,			-- Futures Month
			C.FuturesYear AS FuturesYear,			-- Futures Year
			C.Futures AS Futures,					-- Futures
			C.Premium_Deduct AS PremiumDeduct,		-- Premium / Deduct
			C.ContractAdjustment AS ContractAdjustment,		-- Contract Adjustment
			--CAST(C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID) AS decimal(18,4)) AS AppliedBushels,		-- Applied Bushels
                        Tickets.AppliedBushels AS AppliedBushels,
			C.Bushels - (C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID)) AS Balance,			-- Balance		
			C.SettlementDate AS SettlementDate,		-- Settlement Date
			C.Offer AS Offer,						-- Offer
			C.ContractStatusID AS ContractStatus,	-- Contract Status
			C.SequenceNumber AS SequenceNumber,		-- Sequence Number
			C.SubsequenceNumber AS SubsequenceNumber-- SubsequenceNumber
		FROM dbo.cft_CONTRACT C
			INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = C.FeedMillID
			INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = C.CornProducerID
			INNER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
			INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = C.CornProducerID
                        LEFT OUTER JOIN (SELECT ContractID, SUM(DryBushels) AS AppliedBushels
                                         FROM dbo.cft_PARTIAL_TICKET
                                         GROUP BY ContractID) Tickets ON Tickets.ContractID = C.ContractID 
		WHERE (@FeedMillID IS NULL OR FM.FeedMillID = @FeedMillID) AND (NOT (C.Bushels = C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID) AND C.Cash IS NULL))'

	IF NOT @DeliveryDateFrom IS NULL 
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.DueDateFrom >= @DeliveryDateFrom'
	END


        IF NOT @DeliveryDateTo IS NULL
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.DueDateTo <= @DeliveryDateTo'
	END

	IF ISNULL(@ContractTypeID, 0) <> 0
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND CT.ContractTypeID = @ContractTypeID'
	END

	IF NOT @Price IS NULL 
	BEGIN
		IF @Price = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND NOT C.Cash IS NULL'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Cash IS NULL'
		END
	END

	IF @CornProducer IS NOT NULL AND @CornProducer <> '%'
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.CornProducerID = @CornProducer'
	END
	
	IF NOT @Elevator IS NULL
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND CP.Elevator = @Elevator'
	END
	
	IF NOT @DateEstablished IS NULL
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.DateEstablished = @DateEstablished'
	END

	IF NOT @PurchasePrice IS NULL AND NOT @PurchasePriceMode IS NULL
	BEGIN
		IF @PurchasePriceMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Cash > @PurchasePrice'
		END
		ELSE IF @PurchasePriceMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Cash < @PurchasePrice'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Cash = @PurchasePrice'
		END
	END

	IF NOT @PricedBasis IS NULL AND NOT @PricedBasisMode IS NULL
	BEGIN
		IF @PricedBasisMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.PricedBasis > @PricedBasis'
		END
		ELSE IF @PricedBasisMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.PricedBasis < @PricedBasis'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.PricedBasis = @PricedBasis'
		END
	END

	IF NOT @ContractedBushels IS NULL
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.Bushels = @ContractedBushels'
	END

	IF NOT @Balance IS NULL AND NOT @BalanceMode IS NULL
	BEGIN
		IF @BalanceMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Bushels - (C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID)) > @Balance'
		END
		ELSE IF @BalanceMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Bushels - (C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID)) < @Balance'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Bushels - (C.Bushels - dbo.cffn_CORN_PURCHASING_CONTRACT_GET_FREE_BUSHELS(C.ContractID)) = @Balance'
		END
	END
	
	IF ISNULL(@BasisPeriod, 0) <> 0 
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.BasisMonth = right(@BasisPeriod, 1) AND C.BasisYear = left(@BasisPeriod, 4)'
	END	

	IF ISNULL(@FuturesPeriod, 0) <> 0
	BEGIN
		SET @SQLSelect = @SQLSelect + N' AND C.FuturesMonth = right(@FuturesPeriod, 1) AND C.FuturesYear = left(@FuturesPeriod, 4)'
	END
	
	IF NOT @FuturesPrice IS NULL AND NOT @FuturesPriceMode IS NULL
	BEGIN
		IF @FuturesPriceMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.FuturesBasis > @FuturesPrice'
		END
		ELSE IF @FuturesPriceMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.FuturesBasis < @FuturesPrice'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.FuturesBasis = @FuturesPrice'
		END
	END	

	IF NOT @Futures IS NULL AND NOT @FuturesMode IS NULL
	BEGIN
		IF @FuturesMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Futures > @Futures'
		END
		ELSE IF @FuturesMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Futures < @Futures'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Futures = @Futures'
		END
	END

	IF NOT @Offer IS NULL AND NOT @OfferMode IS NULL
	BEGIN
		IF @OfferMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Offer > @Offer'
		END
		ELSE IF @OfferMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Offer < @Offer'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Offer = @Offer'
		END
	END

	IF ISNULL(@SettlementDate, '--All--') <> '--All--'
	BEGIN 
		SET @SQLSelect = @SQLSelect + N' AND C.SettlementDate = @SettlementDate'
	END

	IF NOT @CRMContract IS NULL 
	BEGIN
		IF @CRMContract = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND CT.CRM = 1'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND CT.CRM = 0'
		END
	END
	
	IF NOT @ContractStatus IS NULL
	BEGIN
		IF @ContractStatus = '001'
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID = 3'
		END
		ELSE IF @ContractStatus = '010'
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID = 2'
		END
		ELSE IF @ContractStatus = '011'
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID IN (2, 3)'
		END
		ELSE IF @ContractStatus = '100'
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID = 1'
		END
		ELSE IF @ContractStatus = '101'
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID IN (1, 3)'
		END
		ELSE IF @ContractStatus = '110'
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID IN (1, 2)'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.ContractStatusID IN (1, 2, 3)'
		END
	END

	IF NOT @PremiumDeduct IS NULL AND NOT @PremiumDeductMode IS NULL
	BEGIN
		IF @PremiumDeductMode = 0
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Premium_Deduct > @PremiumDeduct'
		END
		ELSE IF @PremiumDeductMode = 1
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Premium_Deduct < @PremiumDeduct'
		END
		ELSE
		BEGIN
			SET @SQLSelect = @SQLSelect + N' AND C.Premium_Deduct = @PremiumDeduct'
		END
	END

	CREATE TABLE #Result
	(
		FeedMillName varchar(50),
		CornProducerName varchar(5000),
		Elevator bit,
		ContractNumber varchar(72),
		ContractType varchar(50),
		CRMContractNumber varchar(10),
		DateEstablished smalldatetime,
		ContractedBushels decimal(18,4),
		DeliveryDateFrom smalldatetime,
		DeliveryDateTo smalldatetime,
		PurchasePrice decimal(18,4),
		PricedBasis decimal(18,4),
		BasisMonth tinyint,
		BasisYear smallint,
		FuturesPrice decimal(18,4),
		FuturesMonth tinyint,
		FuturesYear smallint,
		Futures decimal(18,4),
		PremiumDeduct decimal(18,4),
		ContractAdjustment decimal(18,4),
		AppliedBushels decimal(18,4),
		Balance decimal(18,4),		
		SettlementDate datetime,
		Offer money,
		ContractStatus tinyint,
		SequenceNumber int,
		SubsequenceNumber int
	)

	DECLARE @ParamDefinition nvarchar(4000) 	
	SET @ParamDefinition = N'
		@FeedMillID char(10),
		@DeliveryDateFrom smalldatetime,
		@DeliveryDateTo smalldatetime,
		@ContractTypeID int,
		@Price bit,
		@CornProducer varchar(30),
		@Elevator bit,
		@DateEstablished smalldatetime,
		@PurchasePrice money,
		@PurchasePriceMode int,
		@PricedBasis money,
		@PricedBasisMode int,
		@ContractedBushels int,
		@Balance int,
		@BalanceMode int,
		@BasisPeriod varchar(5),
               	@FuturesPeriod varchar(5),
		@FuturesPrice money,
		@FuturesPriceMode int,
		@Futures money,
		@FuturesMode int,
		@Offer money,
		@OfferMode int,
		@SettlementDate	varchar(10),
		@CRMContract bit,
		@ContractStatus char(3),
		@PremiumDeduct money,
		@PremiumDeductMode int'

--	Print @SqlSelect

	INSERT INTO #Result EXECUTE sp_executesql @SqlSelect, @ParamDefinition,	@FeedMillID, @DeliveryDateFrom,	@DeliveryDateTo, @ContractTypeID, @Price,	@CornProducer, @Elevator, @DateEstablished,	@PurchasePrice,	@PurchasePriceMode,	@PricedBasis, @PricedBasisMode, @ContractedBushels,	@Balance, @BalanceMode,	@BasisPeriod, @FuturesPeriod, @FuturesPrice, @FuturesPriceMode,	@Futures, @FuturesMode,	@Offer,	@OfferMode,	@SettlementDate, @CRMContract, @ContractStatus,	@PremiumDeduct,	@PremiumDeductMode
	
	SELECT * FROM #Result
        ORDER BY CornProducerName,
                 ContractNumber,
                 DeliveryDateFrom
	
	DROP TABLE #Result
END

