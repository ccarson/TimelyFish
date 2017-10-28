 CREATE PROCEDURE
	smEmpSc_EmpID_Status_Day
		@parm1	varchar(10),
		@parm2	smalldatetime
AS
	SELECT
		EndDate, EndTime, EmpID, StartDate, StartTime, Status
	FROM
		smEmpSchedule
	WHERE
		EmpID = @parm1 AND
		StartDate <= @parm2 AND
		EndDate   >= @parm2
	ORDER BY
		EmpID,
		StartDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpSc_EmpID_Status_Day] TO [MSDSL]
    AS [dbo];

