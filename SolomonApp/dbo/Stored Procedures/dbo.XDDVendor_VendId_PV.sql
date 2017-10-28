
CREATE PROCEDURE XDDVendor_VendId_PV
  @parm1      	varchar(15)
AS
  Select      	Vendor.VendID, Vendor.Name, XDDDepositor.VendAcct, XDDDepositor.PNStatus, 
		XDDDepositor.Status, XDDDepositor.EntryClass, XDDDepositor.FormatID, XDDDepositor.AcctAppStatus
  FROM        	Vendor Left Outer Join XDDDepositor
  		On Vendor.VendID = XDDDepositor.VendID and XDDDepositor.VendCust = 'V'
  WHERE       	(XDDDepositor.VendAcctDflt = 1 or XDDDepositor.VendAcctDflt Is Null)
		and Vendor.VendId LIKE @parm1
  ORDER BY    	Vendor.VendId, XDDDepositor.VendAcct

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDVendor_VendId_PV] TO [MSDSL]
    AS [dbo];

