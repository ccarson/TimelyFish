CREATE PROCEDURE XDDCustomer_VendId_PV
  @parm1      	varchar(15)
AS
  Select      	Customer.CustID, Customer.Name, XDDDepositor.PNStatus, XDDDepositor.Status, XDDDepositor.EntryClass, XDDDepositor.FormatID, XDDDepositor.AcctAppStatus
  FROM        	Customer Left Outer Join XDDDepositor
  		On Customer.CustID = XDDDepositor.VendID and XDDDepositor.VendCust = 'C'
  WHERE       	Customer.CustID LIKE @parm1
  ORDER BY    	Customer.CustID
