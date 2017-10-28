 CREATE PROCEDURE
	smServFault_EmpID_Zone_Day
		@parm1	varchar(10),
		@parm2	smalldatetime
AS
	SELECT
		smServFault.EmpID, smServFault.ServiceCallID, smServFault.LineNbr, smServCall.CustGeographicID
	FROM
		smServFault, smServCall
	WHERE
		(TaskStatus = 'W' OR TaskStatus = 'R') AND
		smServFault.StartDate = @parm2 AND
		smServFault.EmpID LIKE @parm1 AND
		smServCall.ServiceCallID = smServFault.ServiceCallID
	ORDER BY
		smServFault.ServiceCallID, smServFault.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServFault_EmpID_Zone_Day] TO [MSDSL]
    AS [dbo];

