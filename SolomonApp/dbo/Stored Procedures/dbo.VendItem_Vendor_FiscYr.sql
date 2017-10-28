 /****** Object:  Stored Procedure dbo.VendItem_Vendor_FiscYr    Script Date: 4/16/98 7:50:27 PM ******/
Create Proc VendItem_Vendor_FiscYr @InvtID varchar ( 30), @VendID varchar ( 15), @FiscYr varchar ( 04) as
Select * from VendItem where
        	InvtID = @InvtID And
        	VendID = @VendID And
        	FiscYr = @FiscYr
	Order by InvtId, VendID, FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[VendItem_Vendor_FiscYr] TO [MSDSL]
    AS [dbo];

