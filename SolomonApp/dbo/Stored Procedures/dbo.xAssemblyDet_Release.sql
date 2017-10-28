Create Procedure xAssemblyDet_Release @parm1 varchar (10) as 
    Select * from xAssemblyDet Where AsyNbr = @parm1 and Rlsed = 0
	Order by AsyNbr, KeyFld

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblyDet_Release] TO [MSDSL]
    AS [dbo];

