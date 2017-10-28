 CREATE PROCEDURE
	smConEquipment_All
		@parm1	varchar(10)
		,@parm2 varchar(10)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smConEquipment
 	WHERE
		smConEquipment.ContractId = @parm1
			AND
		smConEquipment.EquipID LIKE @parm2
			AND
		smConEquipment.PMCode LIKE @parm3
	ORDER BY
		smConEquipment.ContractID
		,smConEquipment.EquipId
		,smConEquipment.PMCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConEquipment_All] TO [MSDSL]
    AS [dbo];

