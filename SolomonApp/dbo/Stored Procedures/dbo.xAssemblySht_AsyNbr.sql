Create Procedure xAssemblySht_AsyNbr @parm1 varchar (10) as 
    Select * from xAssemblySht Where AsyNbr Like @parm1
	Order by AsyNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblySht_AsyNbr] TO [MSDSL]
    AS [dbo];

