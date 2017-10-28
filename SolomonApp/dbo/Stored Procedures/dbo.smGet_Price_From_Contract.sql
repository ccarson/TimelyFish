 CREATE PROCEDURE smGet_Price_From_Contract
							@in_ContractID			VARCHAR(10),
							@in_InvtID				VARCHAR(30),
							@in_DetailType			VARCHAR(1),
						    @in_ConMatMarkupID		VARCHAR(10),
							@in_ConLabMarkupID		VARCHAR(10),
							@in_ContractType	 	VARCHAR(10),
							@in_SetupLaborPricing	VARCHAR(1),
							@in_SetupMatPricing		VARCHAR(1),
							@in_InvtValMthd			VARCHAR(1),
							@in_DetailCost			MONEY,
							@in_invtLastCost		MONEY,
							@in_invtStdCost			MONEY,
							@in_CallPMFlag			VARCHAR(1),
							@in_PMMaterialDiscPercent	FLOAT,
							@in_MaterialDiscPercent	FLOAT,
                			@in_LaborDiscPercent 		FLOAT,
                			@in_PMLaborDiscPercent 	FLOAT,
							@out_dUnitPrice 		MONEY 		OUTPUT,
							@out_PriceType 			VARCHAR(1) 	OUTPUT,
							@out_DiscPct 			FLOAT 		OUTPUT
AS
DECLARE
	@BaseOption			VARCHAR(1),		-- smConPricing
	@BasePrice 			MONEY,
	@PriceFound			SMALLINT,
	@TempPer			FLOAT,
	@ArgPriceBasePrice 	MONEY,
	@ArgPriceBaseOption VARCHAR(1)

	SELECT @PriceFound = 0

    -- check smConPricing
	SELECT 	@BaseOption = BaseOption,
			@BasePrice  = BasePrice
	FROM 	smConPricing  (NOLOCK)
	WHERE 	ContractID 	= @in_ContractID
    AND 	Invtid 		= @in_InvtID

	IF @@ROWCOUNT > 0
	BEGIN
        SELECT @PriceFound = 1

        -- regular service call, PM Service Call
        IF RTRIM(@BaseOption) = 'A'
			BEGIN
	            SELECT @out_PriceType = 'A'				-- amount is the price
	            SELECT @out_DiscPct = 0
	            SELECT @out_dUnitPrice = @BasePrice
			END
        Else
			BEGIN
	            SELECT @out_PriceType = 'D'				-- amount is discount Percent
	            SELECT @out_DiscPct = @BasePrice
	            SELECT @out_dUnitPrice = 0.0
			END
	END

    -- check for Mark-up pricing based on cost.  Look for mark-up pricing based on Labor or Materials
    IF @PriceFound = 0
	BEGIN
		IF RTRIM(@in_DetailType) = 'M'
			BEGIN
                -- check for material mark-up
                IF (RTRIM(@in_ConMatMarkupID) <> '') AND
				   (@in_SetupMatPricing = @in_InvtValMthd Or RTRIM(@in_SetupMatPricing) = 'Y')
				BEGIN
                    -- calculate the markup
					EXEC smCalculate_Markup @in_InvtValMthd,     @in_DetailCost,  @in_invtLastCost,
											@in_ConMatMarkupID,  @in_invtStdCost, @out_dUnitPrice OUTPUT

                    SELECT @PriceFound = 1
                    SELECT @out_PriceType = 'A'
                    SELECT @out_DiscPct = 0
                    IF RTRIM(@in_CallPMFlag) = 'P'		-- PM Call
						BEGIN
	                        If @in_PMMaterialDiscPercent > 0 SELECT @out_DiscPct = @in_PMMaterialDiscPercent
						END
                    Else                                -- regular call
						BEGIN
                            If @in_MaterialDiscPercent > 0 SELECT @out_DiscPct = @in_MaterialDiscPercent
						END

                    If @out_DiscPct > 0.0
					BEGIN
                        SELECT @TempPer = 1.0 - (@out_DiscPct / 100)			-- discount based on our pricing
                        SELECT @out_dUnitPrice = @out_dUnitPrice * @TempPer		-- calculate discount
					END
				END
            END

		ELSE IF RTRIM(@in_DetailType) = 'L'
			BEGIN
                -- check for labor mark-up
                IF 	RTRIM(@in_ConLabMarkupID) <> '' AND
					(@in_SetupLaborPricing = @in_InvtValMthd Or RTRIM(@in_SetupLaborPricing) = 'Y')
				BEGIN
					EXEC smCalculate_Markup @in_InvtValMthd,     @in_DetailCost,  @in_invtLastCost,
											@in_ConLabMarkupID,  @in_invtStdCost, @out_dUnitPrice OUTPUT
                    SELECT @PriceFound = 1
                    SELECT @out_PriceType = 'A'
                    SELECT @out_DiscPct = 0

					If @in_LaborDiscPercent > 0 SELECT @out_DiscPct = @in_LaborDiscPercent

                    If @out_DiscPct > 0.0
					BEGIN
                        SELECT @TempPer = 1.0 - (@out_DiscPct / 100) 			-- discount based on our pricing
                        SELECT @out_dUnitPrice = @out_dUnitPrice * @TempPer		-- calculate discount
					END
				END
			END
	END

	-- if price is not from Contract Pricing nor through Markup pricing.
    IF @PriceFound = 0
	BEGIN
        -- check for Agreement special pricing
		SELECT 	@ArgPriceBasePrice = BasePrice,
				@ArgPriceBaseOption = BaseOption
		FROM 	smAgrPricing  (NOLOCK)
		WHERE 	AgreementID = @in_ContractType
		AND 	Invtid 		= @in_InvtID

        IF @@ROWCOUNT > 0
		BEGIN
            SELECT @PriceFound = 1
            -- Agreement price found, regular service call, PM Service Call

            IF RTRIM(@ArgPriceBaseOption) = 'A'
				BEGIN
	                -- amount is the price
	                SELECT @out_PriceType = 'A'
	                SELECT @out_dUnitPrice = @ArgPriceBasePrice
	                SELECT @out_DiscPct = 0
				END
            ELSE
				BEGIN
	                -- amount is discount Percent
	                SELECT @out_PriceType = 'D'
	                SELECT @out_DiscPct = @ArgPriceBasePrice
	                SELECT @out_dUnitPrice = 0.0
				END
		END
    END

    IF @PriceFound = 0
	BEGIN
		IF RTRIM(@in_DetailType) = 'L'
			BEGIN
                IF @in_LaborDiscPercent > 0
				BEGIN
                    SELECT @out_DiscPct = @in_LaborDiscPercent
                    SELECT @out_PriceType = 'D'
                END
			END
		ELSE IF RTRIM(@in_DetailType) = 'M'
			BEGIN
                If @in_MaterialDiscPercent > 0
				BEGIN
                    SELECT @out_DiscPct = @in_MaterialDiscPercent
                    SELECT @out_PriceType = 'D'
				END
			END
	END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smGet_Price_From_Contract] TO [MSDSL]
    AS [dbo];

