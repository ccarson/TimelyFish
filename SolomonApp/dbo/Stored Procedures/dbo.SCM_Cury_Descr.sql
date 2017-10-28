 CREATE	PROCEDURE SCM_Cury_Descr
	@CuryID	VARCHAR(10)
AS
	SELECT	Descr
		FROM	Currncy (NOLOCK)
		WHERE	CuryID = @CuryID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Cury_Descr] TO [MSDSL]
    AS [dbo];

