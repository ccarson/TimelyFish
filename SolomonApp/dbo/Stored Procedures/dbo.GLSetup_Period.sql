CREATE PROCEDURE GLSetup_Period AS
BEGIN
	SELECT BaseCuryId, CpnyName, LastBatNbr, NbrPer, PerNbr, PerRetHist, ZCount, AllowPostOpt, PriorYearPost, ModPriorPost
	FROM GLSetup
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLSetup_Period] TO [MSDSL]
    AS [dbo];

