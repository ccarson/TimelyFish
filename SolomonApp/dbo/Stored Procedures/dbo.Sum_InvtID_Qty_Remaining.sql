
create PROCEDURE Sum_InvtID_Qty_Remaining
	@InvtID 	varchar( 30 )
AS
	SELECT Sum(Qtyremaintoissue)
	FROM  InvProjAlloc
	WHERE InvtId = @InvtId 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Sum_InvtID_Qty_Remaining] TO [MSDSL]
    AS [dbo];

