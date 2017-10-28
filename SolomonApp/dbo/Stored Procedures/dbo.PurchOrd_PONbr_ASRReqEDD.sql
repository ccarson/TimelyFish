 /****** Object:  Stored Procedure dbo.PURCHORD_PONbr_ASRReqEDD   Script Date: 4/16/98 7:50:26 PM ******/
Create Proc PurchOrd_PONbr_ASRReqEDD 
@parm1 varchar ( 10)
AS
    SELECT purchord.* 
    FROM PurchOrd join vs_asrreqedd on purchord.PONbr = vs_asrreqedd.PONbr AND vs_asrreqedd.Doctype = 'U1' 
    WHERE Purchord.ponbr like @parm1 
    ORDER BY purchord.POnbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_PONbr_ASRReqEDD] TO [MSDSL]
    AS [dbo];

