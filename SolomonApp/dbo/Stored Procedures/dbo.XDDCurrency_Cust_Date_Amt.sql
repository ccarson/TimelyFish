
CREATE PROCEDURE XDDCurrency_Cust_Date_Amt
	@CustID		varchar( 15 ),
   	@SetDate	smalldatetime,
   	@CuryAmt	float
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

	if exists 	(select * 
			FROM	curyrate R (nolock) left outer join customer C (nolock)
				on R.fromcuryid = case when C.CuryID = '' then @BaseCuryID
					else C.CuryID
					end
					and R.ToCuryID = @BaseCuryID, cmsetup S (nolock)
			WHERE	C.CustID = @CustID
			and R.ratetype = case when C.CuryRateType = '' then S.ARRtTpDflt
				else C.CuryRateType
				end
			and R.EffDate <= @SetDate 
			)
			
		-- Found CuryRate record
		SELECT TOP 1	case when C.CuryID = '' then @BaseCuryID
					else C.CuryID
					end,
				case when C.CuryRateType = '' then S.ARRtTpDflt
					else C.CuryRateType
					end,
				R.EffDate,	
				R.MultDiv,
				R.Rate,
				Case when R.MultDiv = 'M' then
					Round((@CuryAmt * R.Rate), @BaseCuryPrec)
				else
					Round((@CuryAmt / R.Rate), @BaseCuryPrec)
				end
		FROM		curyrate R (nolock) left outer join customer C (nolock)
				on R.fromcuryid = case when C.CuryID = '' then @BaseCuryID
					else C.CuryID
					end
					and R.ToCuryID = @BaseCuryID, cmsetup S (nolock)
		WHERE		C.CustID = @CustID
				and R.ratetype = case when C.CuryRateType = '' then S.ARRtTpDflt
					else C.CuryRateType
					end
				and R.EffDate <= @SetDate 
		ORDER BY	R.EffDate DESC

	else
		-- No CuryRate record
		SELECT 		@BaseCuryID,
				space(6),
				@CurrDate,	
				'M',
				convert(float, 1),
				@CuryAmt
GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDCurrency_Cust_Date_Amt] TO [MSDSL]
    AS [dbo];

