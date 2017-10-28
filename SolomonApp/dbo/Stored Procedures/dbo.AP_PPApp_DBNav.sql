 CREATE PROCEDURE AP_PPApp_DBNav
	@BatNbr varchar(10),
	@VORefNbr varchar(10)
AS

SELECT *
FROM	AP_PPApplicDet
WHERE	BatNbr LIKE @BatNbr AND VORefNbr LIKE @VORefNbr
ORDER	BY BatNbr,VORefNbr


