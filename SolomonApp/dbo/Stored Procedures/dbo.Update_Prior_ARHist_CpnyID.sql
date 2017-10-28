 /****** Object:  Stored Procedure dbo.Update_Prior_ARHist_CpnyID    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure Update_Prior_ARHist_CpnyID @parm1 float, @parm2 varchar ( 15), @parm3 varchar ( 10), @parm4 varchar ( 4) as
    UPDATE ARHist
    SET ARHist.BegBal = ARHist.BegBal + @parm1
    WHERE ARHist.CustId = @parm2
    AND ARHist.CpnyID = @parm3
    AND ARHist.FiscYr > @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Prior_ARHist_CpnyID] TO [MSDSL]
    AS [dbo];

