

CREATE    Procedure pXF200cftRationExcAll
	@parm1 varchar(30)
as
	Select * 
	From cftRationExc
	WHERE InvtId LIKE @parm1
	Order by InvtId




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF200cftRationExcAll] TO [MSDSL]
    AS [dbo];

