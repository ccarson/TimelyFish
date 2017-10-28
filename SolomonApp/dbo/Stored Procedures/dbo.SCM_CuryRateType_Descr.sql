 CREATE	PROCEDURE SCM_CuryRateType_Descr
	@CuryRtTpID	VARCHAR(10)
AS
	SELECT	Descr
		FROM	CuryRtTp (NOLOCK)
		WHERE	RateTypeId = @CuryRtTpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_CuryRateType_Descr] TO [MSDSL]
    AS [dbo];

