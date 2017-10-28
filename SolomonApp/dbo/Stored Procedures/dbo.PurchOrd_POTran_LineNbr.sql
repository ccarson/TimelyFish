 /****** Object:  Stored Procedure dbo.PurchOrd_POTran_LineNbr    Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_POTran_LineNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
        Select * from POTran where
                PONbr = @parm1 and
                LineNbr between @parm2beg And @parm2end
        Order by PONbr, POLineRef, LineNbr


