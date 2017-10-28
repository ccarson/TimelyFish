
CREATE PROCEDURE XDDGet_BaseCuryID_Prec
AS
	
	-- Get GL Base CuryID
	-- Get GL Base Currency Precision
	SELECT		G.BaseCuryID,
			C.DecPl
	FROM		GLSetup G (nolock) JOIN Currncy C (nolock)
                        ON G.BaseCuryID = C.Curyid

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDGet_BaseCuryID_Prec] TO [MSDSL]
    AS [dbo];

