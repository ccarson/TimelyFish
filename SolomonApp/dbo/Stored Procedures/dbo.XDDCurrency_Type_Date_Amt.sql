
CREATE PROCEDURE XDDCurrency_Type_Date_Amt
   	@CuryID		varchar( 4 ),		-- CuryID of the Batch/Document
	@CuryRateType	varchar( 6 ),
   	@SetDate	smalldatetime,
   	@CuryAmt	float			-- Amount in CuryID Currency
AS
	Declare		@BaseCuryID	varchar(4)
	Declare		@BaseCuryPrec	smallint
	Declare		@CurrDate	smalldatetime
	
	SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)

	-- Get Base CuryID
	-- Get Base Currency Precision
	SELECT		@BaseCuryID = G.BaseCuryID,
			@BaseCuryPrec = C.DecPl
	FROM		GLSetup G (nolock) JOIN Currncy C (nolock)
                        ON G.BaseCuryID = C.Curyid

	if exists ( select * 
			FROM	curyrate R (nolock)
			WHERE	R.FromCuryID = @CuryID
				and R.ToCuryID = @BaseCuryID
				and R.Ratetype = @CuryRateType
				and R.EffDate <= @SetDate 
		  )
	BEGIN		
		-- Found CuryRate record
		SELECT TOP 1	@BaseCuryID,
				@CuryRateType,
				R.EffDate,	
				R.MultDiv,
				R.Rate,
				Case when R.MultDiv = 'M' then
					convert(float, round(  convert(decimal(28,3), @CuryAmt) * convert(decimal(16,9),  R.Rate), @BaseCuryPrec))
				else
					convert(float, round(  convert(decimal(28,3), @CuryAmt) / convert(decimal(16,9),  R.Rate), @BaseCuryPrec))
				end
		FROM		CuryRate R (nolock)
		WHERE		R.FromCuryID = @CuryID
				and R.ToCuryID = @BaseCuryID
				and R.Ratetype = @CuryRateType
				and R.EffDate <= @SetDate 
		ORDER BY	R.EffDate DESC
	END
	
	else
	
	BEGIN
		-- No CuryRate record
		SELECT 		@BaseCuryID,
				space(6),
				@CurrDate,	
				'M',
				convert(float, 1),
				@CuryAmt
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDCurrency_Type_Date_Amt] TO [MSDSL]
    AS [dbo];

