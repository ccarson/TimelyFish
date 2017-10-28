 CREATE PROCEDURE
	smServFault_ServCallId_TechID
		@parm1	varchar(10)
AS
	SELECT
		DISTINCT ServiceCallId, Empid, smEmp.EmployeePagerNo, smEmp.EmployeeLastName, smEmp.EmployeeFirstName
	FROM
		smServFault, smEmp
	WHERE
		Empid <> '' AND
		ServiceCallId LIKE @parm1 AND
		Empid = smEmp.EmployeeId
	ORDER BY
		ServiceCallId, Empid


