 /****** Object:  Stored Procedure dbo.ARHist_CustId_FiscYr1_CpnyID1    Script Date: 11/13/98 12:30:33 PM ******/
Create Procedure ARHist_CustId_FiscYr1_CpnyID1 @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 4) as
    select * from ARHist where CustId = @parm1
    and CpnyID = @parm2
    and FiscYr = @parm3
    order by CustId, FiscYr



