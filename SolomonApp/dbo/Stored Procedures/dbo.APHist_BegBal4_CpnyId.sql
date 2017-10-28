 /****** Object:  Stored Procedure dbo.APHist_BegBal4_CpnyId    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APHist_BegBal4_CpnyId @parm1 float, @parm2 varchar ( 15), @parm3 varchar ( 10), @parm4 varchar ( 4) As
Update APHist set BegBal = BegBal - @parm1
Where VendId = @parm2 and
CpnyId = @parm3 and
FiscYr > @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APHist_BegBal4_CpnyId] TO [MSDSL]
    AS [dbo];

