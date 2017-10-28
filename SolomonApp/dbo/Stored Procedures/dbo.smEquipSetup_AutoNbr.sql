 CREATE PROCEDURE
	smEquipSetup_AutoNbr
AS
	SELECT
		LastEquipmentNbr
	FROM
		smEquipSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEquipSetup_AutoNbr] TO [MSDSL]
    AS [dbo];

