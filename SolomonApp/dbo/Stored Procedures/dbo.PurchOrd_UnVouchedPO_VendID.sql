 CREATE PROCEDURE PurchOrd_UnVouchedPO_VendID @VendID varchar(15)

AS


Select * from Purchord
	where VouchStage <> 'F'
	AND POType in ('OR','DP')
	AND Status in ('M','O','P')
	AND VendID = @VendID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_UnVouchedPO_VendID] TO [MSDSL]
    AS [dbo];

