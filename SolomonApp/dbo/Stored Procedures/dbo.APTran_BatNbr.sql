 /****** Object:  Stored Procedure dbo.APTran_BatNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APTran_BatNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint As
Select * from APTran Where
APTran.BatNbr = @parm1 and
APTran.AcctDist = 0 and
APTran.LineNbr Between @parm2beg and @parm2end
Order By APTran.BatNbr, APTran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APTran_BatNbr] TO [MSDSL]
    AS [dbo];

