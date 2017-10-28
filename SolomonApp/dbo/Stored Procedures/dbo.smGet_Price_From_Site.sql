 CREATE PROCEDURE smGet_Price_From_Site
							@in_CustID				VARCHAR(15),
							@in_ShipToID			VARCHAR(10),
							@in_InvtID				VARCHAR(30),
							@in_invtLastCost		MONEY,
							@in_invtStdCost			MONEY,
							@in_InvtValMthd			VARCHAR(1),
							@in_DetailType			VARCHAR(1),
							@in_DetailCost			MONEY,
						    @in_SOMatMarkupID		VARCHAR(10),
							@in_SOLabMarkupID		VARCHAR(10),
							@in_SetupLaborPricing	VARCHAR(1),
							@in_SetupMatPricing		VARCHAR(1),
							@out_dUnitPrice 		MONEY OUTPUT,
							@out_PriceType 			VARCHAR(1) OUTPUT,
							@out_DiscPct 			FLOAT OUTPUT
AS
DECLARE
	@BaseOption		VARCHAR(1),
	@Amount			FLOAT

	-- check for special site pricing
	SELECT 	@BaseOption = BaseOption,
			@Amount = Amount
	FROM   	smSOPricing  (NOLOCK)
	WHERE  	CustID 	 = @in_CustID
	AND    	ShipToID = @in_ShipToID
	AND    	Invtid   = @in_InvtID

	IF @@ROWCOUNT > 0
	BEGIN
		-- The site has special pricing for the inventory item at this site
        SELECT @out_PriceType = @BaseOption
        IF RTRIM(@out_PriceType) = 'D'
			BEGIN
                -- discount Percent
                SELECT @out_dUnitPrice = 0.0
                SELECT @out_DiscPct = @Amount
			END
		ELSE
			BEGIN
                SELECT @out_dUnitPrice = @Amount
				SELECT @out_DiscPct = 0.0
			END
	END

	-- If the site has Markup apply to the price
	IF RTRIM(@in_DetailType) = 'M'
	    BEGIN
			-- check for material mark-up
			IF 	(RTRIM(@in_SOMatMarkupID) <> '') AND
				(@in_SetupMatPricing = @in_invtValMthd Or RTRIM(@in_SetupMatPricing) = 'Y')
		 		BEGIN
            		-- calculate the markup
					EXEC smCalculate_Markup @in_InvtValMthd,    @in_DetailCost,  @in_invtLastCost,
											@in_SOMatMarkupID,  @in_invtStdCost, @out_dUnitPrice OUTPUT
	    	        SELECT @out_PriceType = 'A'
	        	END
		END
	ELSE IF RTRIM(@in_DetailType) = 'L'
		BEGIN
			-- check for labor mark-up
			IF 	(RTRIM(@in_SOLabMarkupID) <> '') AND
				(@in_SetupLaborPricing = @in_invtValMthd Or RTRIM(@in_SetupLaborPricing) = 'Y')
				BEGIN
					-- calculate the markup
					EXEC smCalculate_Markup @in_InvtValMthd,    @in_DetailCost,  @in_invtLastCost,
											@in_SOLabMarkupID,  @in_invtStdCost, @out_dUnitPrice OUTPUT
            	    SELECT @out_PriceType = 'A'
				END
		END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smGet_Price_From_Site] TO [MSDSL]
    AS [dbo];

