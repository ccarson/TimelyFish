	CREATE PROCEDURE chkstub_all @parm1 As char(10)
AS	
		Select * from PRDoc 
			where DocType = 'CK' 
			and ChkNbr like @parm1 
			order by ChkNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[chkstub_all] TO [MSDSL]
    AS [dbo];

