
CREATE PROCEDURE XDDCurrency_From_To
   	@FromCuryID	varchar( 4 ),	
   	@ToCuryID	varchar( 4 ),	
	@CuryRateType	varchar( 6 ),
   	@EffDate	smalldatetime,
   	@FromCuryAmt	float,		-- Amount in From Currency
	@ReturnSelect	smallint,	-- 
   	@ToRate		float OUTPUT,	-- Rate for conversion
	@ToMultDiv	varchar( 1 ) OUTPUT,
	@ToEffDate	smalldatetime OUTPUT,
   	@ToCuryAmt	float OUTPUT	-- Amount in CuryID Currency

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
			WHERE	R.FromCuryID = @FromCuryID
				and R.ToCuryID = @ToCuryID
				and R.Ratetype = @CuryRateType
				and R.EffDate <= @EffDate 
		  )
	BEGIN		
		-- Found CuryRate record
		SELECT TOP 1	-- @BaseCuryID,
				-- @CuryRateType,
				@ToEffDate = R.EffDate,	
				@ToMultDiv = R.MultDiv,
				@ToRate = R.Rate,
				@ToCuryAmt = Case when R.MultDiv = 'M' 
					then convert(float, round(  convert(decimal(28,3), @FromCuryAmt) * convert(decimal(16,9),  R.Rate), @BaseCuryPrec))
					else convert(float, round(  convert(decimal(28,3), @FromCuryAmt) / convert(decimal(16,9),  R.Rate), @BaseCuryPrec))
					end
		FROM		CuryRate R (nolock)
		WHERE		R.FromCuryID = @FromCuryID
				and R.ToCuryID = @ToCuryID
				and R.Ratetype = @CuryRateType
				and R.EffDate <= @EffDate 
		ORDER BY	R.EffDate DESC
	END
	
	else

	BEGIN
		-- From/To didn't work, try To/From
		if exists ( select * 
				FROM	curyrate R (nolock)
				WHERE	R.FromCuryID = @ToCuryID
					and R.ToCuryID = @FromCuryID
					and R.Ratetype = @CuryRateType
					and R.EffDate <= @EffDate 
			  )
		BEGIN		
			-- Found CuryRate record
			SELECT TOP 1	-- @BaseCuryID,
					-- @CuryRateType,
					@ToEffDate = R.EffDate,
					@ToMultDiv = R.MultDiv,
					@ToRate = R.RateReciprocal,
					@ToCuryAmt = Case when R.MultDiv = 'M'
						then convert(float, round(  convert(decimal(28,3), @FromCuryAmt) * convert(decimal(16,9),  R.RateReciprocal), @BaseCuryPrec))
						else convert(float, round(  convert(decimal(28,3), @FromCuryAmt) / convert(decimal(16,9),  R.RateReciprocal), @BaseCuryPrec))
					        end
			FROM		CuryRate R (nolock)
			WHERE		R.FromCuryID = @ToCuryID
					and R.ToCuryID = @FromCuryID
					and R.Ratetype = @CuryRateType
					and R.EffDate <= @EffDate 
			ORDER BY	R.EffDate DESC
		END

		else

		BEGIN
			-- No CuryRate record
			SET @ToMultDiv	= 'M'
			SET @ToEffDate 	= @CurrDate
			SET @ToRate 	= convert(float, 1)
			SET @ToCuryAmt 	= @FromCuryAmt
		END
	END

	-- If Return Select, then send back vars
	if @ReturnSelect = 1
   		SELECT @ToRate, @ToMultDiv, @ToEffDate,	@ToCuryAmt
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDCurrency_From_To] TO [MSDSL]
    AS [dbo];

