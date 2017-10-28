 /****** Object:  Stored Procedure dbo.VENDOR_VENDID_ASRReqEDD    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure VENDOR_VENDID_ASRReqEDD 
@parm1 varchar ( 15) as

Select Vendor.* 
FROM Vendor join vs_asrreqedd on Vendor.vendid = vs_asrreqedd.vendid and vs_asrreqedd.doctype = 'U1' 
WHERE Vendor.VendId like @parm1  
ORDER BY Vendor.VendId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[VENDOR_VENDID_ASRReqEDD] TO [MSDSL]
    AS [dbo];

