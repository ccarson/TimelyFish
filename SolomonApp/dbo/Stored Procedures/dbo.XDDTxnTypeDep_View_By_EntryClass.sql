
CREATE PROCEDURE XDDTxnTypeDep_View_By_EntryClass
   @VendCust	varchar(1),
   @VendID		varchar(15),	
   @EntryClass	varchar(4)

AS
   SELECT       *
   FROM		XDD_vp_TxnTypeDep
   WHERE	VendCust = @VendCust
   		and VendID = @VendID
   		and T_EntryClass LIKE @EntryClass
   ORDER BY	T_EntryClass

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTxnTypeDep_View_By_EntryClass] TO [MSDSL]
    AS [dbo];

