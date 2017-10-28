Create Procedure xMarionCpny_Comp @parm1 varchar (10) as 
    Select * from xMarionCpny Where Comptr Like @parm1
	Order by Comptr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xMarionCpny_Comp] TO [MSDSL]
    AS [dbo];

