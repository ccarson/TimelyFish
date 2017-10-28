 CREATE PROCEDURE ADG_Employee_Descr
	@parm1 varchar(10)
AS
	SELECT Name
	FROM Employee
	WHERE EmpId = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


