 /****** Object:  Stored Procedure dbo.POTran_RcptNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create proc POTran_RcptNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
        Select * from POTran where RcptNbr = @parm1
            and LineNbr between @parm2beg and @parm2end
            Order by RcptNbr, LineNbr


