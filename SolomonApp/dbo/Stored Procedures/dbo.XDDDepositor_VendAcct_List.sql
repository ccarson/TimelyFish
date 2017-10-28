
CREATE PROCEDURE XDDDepositor_VendAcct_List
   @VendID	varchar(15)
AS

   declare @VendAcctList	varchar(255)
   
   -- Default the value
   SET	@VendAcctList = ''
   
   if exists(Select * from XDDDepositor Where VendCust = 'V' and VendID = @VendID)
   BEGIN
   	   
	   SELECT       @VendAcctList = @VendAcctList + rtrim(VendAcct) + ';' + rtrim(VendAcct) + ','
	   FROM		XDDDepositor
	   WHERE	VendCust = 'V'
			and Status = 'Y'
	   		and VendID = @VendID
	   ORDER BY	VendAcct

	   if len(@VendAcctList) > 0
	   	SET	@VendAcctList = left(@VendAcctList, len(@VendAcctList) - 1)
   END
   else
	SET @VendAcctList = ' ;Not EFT Vendor'

   SELECT	@VendAcctList

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_VendAcct_List] TO [MSDSL]
    AS [dbo];

