 /****** Object:  Stored Procedure dbo.ARTran_Bat    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARTran_Bat @parm1 varchar ( 10) as
    Select * from ARTran
    where BatNbr = @parm1
    order by BatNbr, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_Bat] TO [MSDSL]
    AS [dbo];

