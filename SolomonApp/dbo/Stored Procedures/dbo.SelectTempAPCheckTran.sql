 /****** Object:  Stored Procedure dbo.SelectTempAPCheckTran    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure SelectTempAPCheckTran @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 8), @parm4 varchar (1) As
Select * From APTran
Where APTran.VendId = @parm1
and APTran.UnitDesc = @parm2
and APTran.CostType = @parm3
and APTran.PmtMethod LIKE @parm4
and APTran.DrCr = 'S'
and RefNbr = ''
Order By Acct, Sub, RefNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SelectTempAPCheckTran] TO [MSDSL]
    AS [dbo];

