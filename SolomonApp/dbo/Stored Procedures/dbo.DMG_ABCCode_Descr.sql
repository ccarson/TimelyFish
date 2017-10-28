 CREATE PROCEDURE DMG_ABCCode_Descr
	@ABCCode		varchar( 2 )
AS
	SELECT 			Descr
	FROM 			PIABC
	WHERE 			ABCCode = @ABCCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ABCCode_Descr] TO [MSDSL]
    AS [dbo];

