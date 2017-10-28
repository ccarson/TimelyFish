 /****** Object:  Stored Procedure dbo.PurOrdLSDet_PONbr_LineId                                 ******/
Create Proc PurOrdLSDet_PONbr_LineId @parm1 varchar ( 10), @parm2 int as
       Select * from PurOrdLSDet
                where PONbr = @parm1
                  and LineId = @parm2
                order by PONbr, LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_PONbr_LineId] TO [MSDSL]
    AS [dbo];

