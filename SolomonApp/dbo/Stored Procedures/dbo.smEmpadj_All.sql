 CREATE PROCEDURE
	smEmpadj_All
		@parm1	varchar(10)
		,@parm2beg	smallint
		,@parm2end 	smallint
AS
	SELECT
		EmpAdjID
		,EmpAdjAmount
		,EmpAdjDocument
		,EmpAdjNotes
		,EmpAdjSalesOrder
		,EmpAdjTypeID
		,smEmpAdj.User1
		,smEmpAdj.User2
		,smEmpAdj.User3
		,smEmpAdj.User4
		,linenbr
		,EmployeeFirstName
		,EmployeeLastName
		,EmployeeMiddleInit
		,EmployeeId
	FROM
		smEmpAdj
		,smEmp
	WHERE
		empadjid = employeeId
			AND
		EmpAdjId = @parm1
			AND
		Linenbr  BETWEEN @parm2beg AND @parm2end
	ORDER BY
	EmpAdjID
	,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpadj_All] TO [MSDSL]
    AS [dbo];

