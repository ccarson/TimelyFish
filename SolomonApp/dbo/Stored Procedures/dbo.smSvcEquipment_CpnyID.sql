 CREATE PROCEDURE
	smSvcEquipment_CpnyID
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSvcEquipment
	WHERE
		Status = 'A'
			AND
		EquipID LIKE @parm1
	ORDER BY
		EquipID


