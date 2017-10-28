 CREATE Proc EDConvMeth_Description @Parm1 varchar(3), @Parm2 varchar(3), @Parm3 varchar(1) As
Select Description From EDConvMeth Where Trans = @Parm1 And ConvCode = @Parm2 And Direction = @Parm3


