Create Procedure xAssemblyDet_AsyNbr_MaxKey @parm1 varchar (10) as 
    Select Convert(smallint, Max(KeyFld)) from xAssemblyDet Where AsyNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblyDet_AsyNbr_MaxKey] TO [MSDSL]
    AS [dbo];

