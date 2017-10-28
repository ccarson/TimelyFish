 CREATE PROCEDURE
	smSvcEq_Custid_CpnyID
		@parm1	varchar(15)
		,@parm2	varchar(10)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smSvcEquipment
	WHERE
		Status = 'A'
			AND
		CustId = @parm1
			AND
		SiteId = @parm2
			AND
		EquipID LIKE @parm3
	ORDER BY
		CustID, SiteID, EquipID


