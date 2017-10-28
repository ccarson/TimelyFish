 /****** Object:  Stored Procedure dbo.EDConvMeth_All    Script Date: 5/28/99 1:17:40 PM ******/
CREATE Proc EDConvMeth_AllDMG @Parm1 varchar(3), @Parm2 varchar(3) As select * From EDConvMeth
Where Trans = @Parm1 And ConvCode Like @Parm2 Order By Trans, ConvCode


