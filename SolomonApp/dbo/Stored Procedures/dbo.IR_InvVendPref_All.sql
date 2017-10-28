 Create Procedure IR_InvVendPref_All @InvtID VarChar(30), @VendId varchar(15) as
	Select * from IR_InvVendPref where InvtId = @InvtId and VendId Like @VendId order by InvtId, VendID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IR_InvVendPref_All] TO [MSDSL]
    AS [dbo];

