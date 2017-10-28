
CREATE PROCEDURE XDDTxnTypeDep_EStatus_List
   @VendID	varchar(15),
   @VendAcct	varchar(10)

AS

   declare @EStatusList			varchar(255)
   
   -- Default the value
   SET		@EStatusList = ' ;SL Check'
   
   if exists(Select * from XDD_vp_TxnTypeDep Where VendCust = 'V' and VendID = @VendID and VendAcct = @VendAcct)
   BEGIN
   	   SET		@EStatusList = ''
   	   
	   SELECT       @EStatusList = @EStatusList + EStatus + ';' + rtrim(DescrShort) + ','
	   FROM			XDD_vp_TxnTypeDep
	   WHERE		VendCust = 'V'
	   			and VendID = @VendID
				and VendAcct = @VendAcct
	   			and Selected = 1
	   ORDER BY	EStatus

	   if len(@EStatusList) > 0
	   	SET	@EStatusList = left(@EStatusList, len(@EStatusList) - 1)
   END
   
   SELECT	@EStatusList

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDTxnTypeDep_EStatus_List] TO [MSDSL]
    AS [dbo];

