 CREATE PROCEDURE
	smConMaster_CpnyID
		 @parm1 varchar(10)
		,@parm2 varchar(10)

AS
	SELECT
		*
	FROM
		smConMaster
	WHERE
		EXISTS (SELECT * FROM smBranch WHERE CpnyID = @parm1 AND branchid = smConmaster.Branchid)
			AND
		MasterId LIKE @parm2
	ORDER BY
		CustID
		,MasterId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConMaster_CpnyID] TO [MSDSL]
    AS [dbo];

