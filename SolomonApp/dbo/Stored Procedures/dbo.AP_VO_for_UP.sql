 CREATE PROCEDURE AP_VO_for_UP
	@VendId varchar(15),
	@CuryId varchar(4),
	@RefNbr varchar(10)
AS

SELECT	*
FROM	APDoc
WHERE	Status='A'
AND	VendID LIKE @VendID
AND	CuryId LIKE @CuryId
AND	Rlsed=1
AND	RefNbr LIKE @RefNbr
AND	DocType='VO'
ORDER BY RefNbr


