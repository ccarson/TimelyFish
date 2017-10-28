 /****** Object:  Stored Procedure dbo.Delete_PurOrdLSDet_PONbr_LnId                            ******/
Create Proc Delete_PurOrdLSDet_PONbr_LnId @parm1 varchar ( 10), @parm2 int as
    Delete PurOrdLSDet from PurOrdLSDet
                where PurOrdLSDet.PONbr = @parm1
                  and PurOrdLSDet.LineId = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_PurOrdLSDet_PONbr_LnId] TO [MSDSL]
    AS [dbo];

