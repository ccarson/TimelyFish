Create Procedure xAssemblyDet_AsyNbr_KeyFld @parm1 varchar (10), @parm2 varchar (10) as 
    Select * from xAssemblyDet Where AsyNbr = @parm1 and KeyFld Like @parm2 
	Order by AsyNbr, KeyFld

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblyDet_AsyNbr_KeyFld] TO [MSDSL]
    AS [dbo];

