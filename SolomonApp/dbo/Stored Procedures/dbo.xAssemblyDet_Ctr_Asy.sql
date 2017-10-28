Create Procedure xAssemblyDet_Ctr_Asy @parm1 varchar (10), @parm2 varchar (10) as 
    Select * from xAssemblyDet Where CtrctNbr = @parm1 and AsyNbr Like @parm2 
	Order by CtrctNbr, AsyNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblyDet_Ctr_Asy] TO [MSDSL]
    AS [dbo];

