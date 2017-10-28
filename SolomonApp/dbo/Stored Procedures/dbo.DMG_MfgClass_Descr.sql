 CREATE PROCEDURE DMG_MfgClass_Descr
	@MfgClassID		varchar(10)
AS
	SELECT 			Descr
	FROM 			BMMfgClass
	WHERE 			MfgClassID = @MfgClassID


