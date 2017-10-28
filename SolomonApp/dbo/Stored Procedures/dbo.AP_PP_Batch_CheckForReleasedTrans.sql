 CREATE PROCEDURE AP_PP_Batch_CheckForReleasedTrans @BatNbr varchar(10)
AS

SELECT 	count(*)
FROM	AP_PPApplicDet
WHERE	BatNbr = @BatNbr
AND	Rlsed = 1


