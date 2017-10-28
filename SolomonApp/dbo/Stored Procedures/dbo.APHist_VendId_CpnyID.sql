 /****** Object:  Stored Procedure dbo.APHist_VendId_CpnyID    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APHist_VendId_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 4) As
Select * from APHist where VendId = @parm1 and
CpnyID LIKE @parm2
and FiscYr = @parm3
Order By VendId, CpnyId, FiscYr


