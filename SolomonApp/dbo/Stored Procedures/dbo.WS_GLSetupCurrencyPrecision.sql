CREATE PROCEDURE WS_GLSetupCurrencyPrecision
	As
	SELECT	DecPl
	FROM 	Currncy (nolock)
	WHERE	CuryID = (select BaseCuryID from GLSetup (nolock))
