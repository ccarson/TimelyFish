 /****** Object:  Stored Procedure dbo.APHist_BegBal1_CpnyId    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APHist_BegBal1_CpnyId @parm1 float, @parm2 varchar ( 15), @parm3 varchar ( 10), @parm4 varchar ( 4), @parm5 varchar ( 4) As
Update APHist Set BegBal = BegBal + @parm1
Where Vendid = @parm2 and
CpnyId = @parm3 and FiscYr > @parm4 and FiscYr <= @parm5


