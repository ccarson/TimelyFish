
CREATE PROCEDURE XDDTxnTypeDep_View_All
   @VendCust		varchar(1),
   @VendID		varchar(15),
   @VendAcct		varchar(10),
   @EStatus		varchar(1)

AS
   SELECT       *
   FROM		XDD_vp_TxnTypeDep
   WHERE	VendCust = @VendCust
   		and VendID = @VendID
		and VendAcct = @VendAcct
   		and EStatus LIKE @EStatus
   ORDER BY	EStatus

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTxnTypeDep_View_All] TO [MSDSL]
    AS [dbo];

