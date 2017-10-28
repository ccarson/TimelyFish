

CREATE PROC Check_INTranPeriod_FiscYear

AS
	Set NoCount ON
	Declare @FiscalYear smallint

	SELECT @FiscalYear  = convert(smallint, substring(PerNbr, 1, 4)) FROM GLSetup
		SELECT	Distinct BatNbr, PerPost
	FROM	INTRAN T
	WHERE	Abs(convert(smallint, substring(T.PerPost, 1, 4)) - @FiscalYear) >= 5
		And T.PerPost <> ''
	ORDER BY BatNbr


