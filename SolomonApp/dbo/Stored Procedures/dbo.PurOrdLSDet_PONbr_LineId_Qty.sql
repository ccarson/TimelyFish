 /****** Object:  Stored Procedure dbo.PurOrdLSDet_PONbr_LineId_Qty                             ******/
Create Proc PurOrdLSDet_PONbr_LineId_Qty @parm1 varchar ( 10), @parm2 int as
Select PONbr, LineId, sum(Qty) from PurOrdLSDet
       where  PONbr = @parm1 and
 	       LineId = @parm2
   	 Group By  PONbr, LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_PONbr_LineId_Qty] TO [MSDSL]
    AS [dbo];

