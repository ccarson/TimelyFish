Create Procedure xAssemblyDet_Ctr_NotAsy @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (10) as 
    Select Sum(Bushels) from xAssemblyDet Where CtrctNbr = @parm1 and (AsyNbr <> @parm2 or KeyFld <> @parm3)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssemblyDet_Ctr_NotAsy] TO [MSDSL]
    AS [dbo];

