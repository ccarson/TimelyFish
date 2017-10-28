 CREATE PROCEDURE smConvert_Units
	@Amt 			MONEY,
	@in_invtStkUnit VARCHAR(6),
	@in_UnitDesc	VARCHAR(6),
	@in_InvtID		VARCHAR(30),
	@in_InvtClassID	VARCHAR(6),
	@outConvAmt 	MONEY OUTPUT

AS
DECLARE
	@UnitFactor  		FLOAT,
	@UnitMultDiv 		VARCHAR(1),
	@InUnitFactor		FLOAT,
	@InUnitMultDiv		VARCHAR(1),
    @FOUND_CNV			SMALLINT,
	@UNIT_REVERSE		SMALLINT

	-- Get the conversion factor
    SELECT @UnitFactor = 1.0
    SELECT @UnitMultDiv = 'M'
	SELECT @InUnitFactor = 1.0
	SELECT @InUnitMultDiv = 'M'
    SELECT @FOUND_CNV = 0
	SELECT @UNIT_REVERSE = 0

    -- If the entered uom is not the same as the inventory stock unit
    If RTRIM(@in_UnitDesc) <> RTRIM(@in_invtStkUnit)
	BEGIN
		-- Use the Solomon routine to get the unit conversion items
		-- The stored procedure will try to get the convertion FROM->TO or TO->FROM
		EXEC @FOUND_CNV = _sm_InUnit_InvtId_From_To 	@in_InvtID, @in_UnitDesc, @in_invtStkUnit,
														@InUnitFactor OUTPUT, @InUnitMultDiv OUTPUT, @UNIT_REVERSE OUTPUT
		IF @FOUND_CNV = 0
		BEGIN
			EXEC @FOUND_CNV = _sm_InUnit_ClassId_From_To @in_InvtClassID, @in_UnitDesc, @in_invtStkUnit,
														 @InUnitFactor OUTPUT, @InUnitMultDiv OUTPUT, @UNIT_REVERSE OUTPUT
			IF @FOUND_CNV = 0
			BEGIN
				EXEC @FOUND_CNV = _sm_InUnit_Global_From_To 	@in_UnitDesc, @in_invtStkUnit,
																@InUnitFactor OUTPUT, @InUnitMultDiv OUTPUT, @UNIT_REVERSE OUTPUT
    		END
		END

    	IF @FOUND_CNV = 1
		BEGIN
			SELECT @UnitMultDiv = @InUnitMultDiv
			SELECT @UnitFactor = @InUnitFactor

	       	IF @UNIT_REVERSE = 1
			BEGIN
         		IF 	 @InUnitMultDiv = 'M' SELECT @UnitMultDiv = 'D'
				ELSE 					  SELECT @UnitMultDiv = 'M'
			END
		END
	END

    -- Verify the UnitMultDiv argument.
	IF RTRIM(@UnitMultDiv) <> 'D' AND RTRIM(@UnitMultDiv) <> 'M'
	BEGIN
        -- Set an undefined conversion type to be "multiply."
        SELECT @UnitMultDiv = 'M'
	END

    -- Do not allow a zero or negative conversion factor.
    IF @UnitFactor <= 0 SELECT @UnitFactor = 1.0

    -- Perform the conversion.
	IF @UnitMultDiv = 'D' SELECT @outConvAmt = @Amt / @UnitFactor
	ELSE SELECT @outConvAmt = @Amt * @UnitFactor



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConvert_Units] TO [MSDSL]
    AS [dbo];

