

CREATE   Procedure pXF20000cftRationExcAll
	@parm1 varchar(30)
as
	Select cftRationExc.* 
	From cftRationExc
	WHERE InvtId LIKE @parm1
	Order by InvtId


