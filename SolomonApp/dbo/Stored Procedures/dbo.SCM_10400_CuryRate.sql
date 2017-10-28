 Create	Procedure SCM_10400_CuryRate
	@FromCuryID	VarChar(4),
	@ToCuryID	VarChar(4),
	@RateType	VarChar(6),
	@EffDate	SmallDateTime
As
	Select	Top 1
		*
		From	CuryRate (NoLock)
		Where 	FromCuryId = @FromCuryID
			And ToCuryID = @ToCuryID
			And RateType = @RateType
			And EffDate <= @EffDate
		Order By EffDate Desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_CuryRate] TO [MSDSL]
    AS [dbo];

