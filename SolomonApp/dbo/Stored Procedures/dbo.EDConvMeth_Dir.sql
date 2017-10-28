 CREATE Proc EDConvMeth_Dir @Parm1 varchar(3), @Parm2 varchar(1), @Parm3 varchar(3) As
Select * From EDConvMeth Where Trans = @Parm1 And Direction = @Parm2
And ConvCode Like @Parm3 Order By ConvCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConvMeth_Dir] TO [MSDSL]
    AS [dbo];

