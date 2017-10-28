 CREATE PROCEDURE Check_Currency_EffData
	@CuryEffDate	SMALLDATETIME,
	@CuryIDTo	VARCHAR(04),
	@CuryIDFrom	VARCHAR(04),
	@CuryRateType	VARCHAR(06)

AS
	SELECT	*
	FROM	CuryRate
	WHERE	EffDate <= @CuryEffDate
	and 	ToCuryID = @CuryIDTo
	and 	FromCuryID = @CuryIDFrom
	and 	RateType = @CuryRateType
	order by EffDate DESC


