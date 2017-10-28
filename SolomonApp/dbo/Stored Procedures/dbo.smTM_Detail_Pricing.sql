 CREATE PROCEDURE smTM_Detail_Pricing
	@szServCallID	VARCHAR(10),
	@szCustID		VARCHAR(15),
	@szShiptoID		VARCHAR(10),
	@szInvtID		VARCHAR(30),
	@UnitCost		MONEY,
	@UnitPrice		MONEY	OUTPUT
AS

DECLARE
	@RetUnitPrice   		money,
	@DetailType 			varchar(1),		-- smServDetail

	@InvtValMthd			varchar(1),		-- Inventory
	@InvtStkBasePrc			money,
	@InvtDfltSOUnit			varchar(6),
    @InvtStkUnit 			varchar(6),
	@InvtClassID 			varchar(6),
	@InvtLastCost			MONEY,
	@InvtStdCost			MONEY,

	@SetupLabPricing 		varchar(1),		-- smProServSetup
	@SetupMatPricing 		varchar(1),

	@ConPrcPMOption			varchar(1),		-- smConPricing
	@ConPrcPMPrice			money,
	@ConPrcBaseOption		varchar(1),
	@ConPrcBasePrice		money,

	@ContractID				VARCHAR(10),	-- smServCall
	@PMFlag					VARCHAR(1),

   	@SOLabMarkupID 			VARCHAR(10),	-- smSOAddress
	@SOMatMarkupID 			VARCHAR(10),

	@LaborDiscPercent      	FLOAT,			-- smAgreement
    @MaterialDiscPercent   	FLOAT,
    @PMLaborDiscPercent 	FLOAT,
    @PMMaterialDiscPercent 	FLOAT,

	@ConMatMarkupID			VARCHAR(10),	-- smContract
	@ConLabMarkupID			VARCHAR(10),
	@ContractType			VARCHAR(10),

	@DiscPct 				FLOAT,
	@PriceType 				VARCHAR(1),
	@TempPer				FLOAT

	SELECT @RetUnitPrice = 0.00
	SELECT @UnitPrice = 0.00
	SELECT @DiscPct = 0.0
	SELECT @PriceType = 'D'
	SELECT @LaborDiscPercent = 0.0
   	SELECT @MaterialDiscPercent = 0.0
   	SELECT @PMLaborDiscPercent = 0.0
   	SELECT @PMMaterialDiscPercent = 0.0
	SELECT @SOLabMarkupID = ''
	SELECT @SOMatMarkupID = ''

	SELECT @ContractID = ContractID,
		   @PMFlag     = PMFlag
	FROM   smServCall  (NOLOCK)
	WHERE  ServiceCallId  = @szServCallID
	AND    cmbInvoiceType = 'T'
	IF @@ROWCOUNT <= 0
	BEGIN
		print 'Invalid Service CallID'
		GOTO ABORT_PROC
	END

	-- Get record from inventory
	SELECT @DetailType 		= InvtType,
	       @InvtValMthd 	= ValMthd,
	       @InvtStkBasePrc 	= StkBasePrc,
	       @InvtDfltSOUnit 	= DfltSOUnit,
	       @InvtStkUnit 	= StkUnit,
	       @InvtClassID 	= ClassID,
		   @InvtLastCost    = LastStdCost,
	       @InvtStdCost		= StdCost
	FROM   INVENTORY (NOLOCK)
	WHERE  InvtId = @szInvtID
	IF @@ROWCOUNT <= 0
	BEGIN
		print 'Invalid Inventory ID'
		GOTO ABORT_PROC
	END

	-- If the inventory is Labor, then, leave it as Labor; otherwise, set it Material
    IF RTRIM(@DetailType) <> 'L'  SELECT @DetailType = 'M'

	SELECT @SetupLabPricing = LabPricing,
	       @SetupMatPricing = MatPricing
	FROM   smProServSetup (NOLOCK)
	IF @@ROWCOUNT <= 0
	BEGIN
		print 'Service Series is not setup'
		GOTO ABORT_PROC
	END

	SELECT @SOLabMarkupID = LabMarkupID,
		   @SOMatMarkupID = MatMarkupID
	FROM   SMSOADDRESS (NOLOCK)
	WHERE  CustID 	= @szCustID
	AND    ShiptoId = @szShipToID

	If RTRIM(@ContractID) > ''
		BEGIN
			-- Contract pricing
            SELECT  @LaborDiscPercent      	= smAgreement.LaborPct,
                	@MaterialDiscPercent   	= smAgreement.MaterialPct,
                	@PMLaborDiscPercent 	= smAgreement.PMLaborPct,
                	@PMMaterialDiscPercent 	= smAgreement.PMMaterialPct,
					@ConMatMarkupID 		= smcontract.MatMarkupID,
					@ConLabMarkupID 		= smcontract.LabMarkupID,
					@ContractType 			= smcontract.ContractType
			FROM 	smcontract, smAgreement (NOLOCK)
			WHERE 	smcontract.ContractType = smAgreement.AgreementTypeID
			AND 	smcontract.ContractId = @ContractID

			IF @@ROWCOUNT <= 0
			BEGIN
				print 'Invalid Contract ID & information'
				GOTO ABORT_PROC
			END

			EXEC smGet_Price_From_Contract	@ContractID, 			@szInvtID, 				@DetailType,
											@ConMatMarkupID,  		@ConLabMarkupID,		@ContractType,
											@SetupLabPricing, 		@SetupMatPricing,		@InvtValMthd,
											@UnitCost,				@InvtLastCost, 		  	@InvtStdCost,
											@PMFlag, 				@PMMaterialDiscPercent,	@MaterialDiscPercent,
											@LaborDiscPercent, 		@PMLaborDiscPercent,
											@RetUnitPrice OUTPUT,   @PriceType OUTPUT, 		@DiscPct OUTPUT
		END
	Else
		BEGIN
			-- Site pricing
			EXEC smGet_Price_From_Site  @szCustID, 		  		@szShiptoID,  		@szInvtID,
										@InvtLastCost,	  		@InvtStdCost,	  	@InvtValMthd,
										@DetailType, 			@UnitCost,			@SOMatMarkupID,
										@SOLabMarkupID, 		@SetupLabPricing, 	@SetupMatPricing,
										@RetUnitPrice OUTPUT,   @PriceType OUTPUT, 	@DiscPct OUTPUT
		END

	IF @PriceType = 'D'
	BEGIN
	    SELECT @RetUnitPrice = @InvtStkBasePrc

	    IF @DiscPct > 0.0
		BEGIN
			SELECT @TempPer = 1 - (@DiscPct / 100)				-- discount based on our pricing
    	    SELECT @RetUnitPrice = @RetUnitPrice * @TempPer		-- calculate discount
	 	END
	END

	-- Unit Price
	SELECT @UnitPrice = @RetUnitPrice
	IF RTRIM(@InvtStkUnit) <> RTRIM(@InvtDfltSOUnit)
	BEGIN
		EXEC smConvert_Units @UnitPrice, @InvtStkUnit, @InvtDfltSOUnit, @szInvtID, @InvtClassID, @RetUnitPrice OUTPUT
		SELECT @UnitPrice = @RetUnitPrice
	END
	GOTO END_PROC
	ABORT_PROC:
	SELECT @UnitPrice = @RetUnitPrice
	RETURN 0

END_PROC:
	RETURN 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smTM_Detail_Pricing] TO [MSDSL]
    AS [dbo];

