
CREATE PROCEDURE XDDTxnTypeDep_View_EntryClass
   @VendCust	varchar(1),
   @VendID	varchar(15),	
   @VendAcct	varchar(10),
   @EntryClass	varchar(4)

AS
   SELECT       EStatus, EntryClassCanChg
   FROM		XDD_vp_TxnTypeDep
   WHERE	VendCust = @VendCust
   		and VendID = @VendID
		and VendAcct = @VendAcct
   		and T_EntryClass LIKE @EntryClass
   ORDER BY	EntryClass

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTxnTypeDep_View_EntryClass] TO [MSDSL]
    AS [dbo];

