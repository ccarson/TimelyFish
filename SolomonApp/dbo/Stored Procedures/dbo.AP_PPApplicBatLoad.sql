 CREATE PROCEDURE AP_PPApplicBatLoad
	@BatNbr varchar(10)
AS

SELECT	* FROM AP_PPApplicBat
WHERE	BatNbr LIKE @BatNbr
ORDER	BY BatNbr


