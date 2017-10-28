CREATE PROCEDURE XDDAPCheck_BatNbr
   @BatNbr      varchar(10)
as
   Select 	* from APCheck
   WHERE        BatNbr = @BatNbr
   ORDER BY     BatNbr, Acct, Sub, CheckRefNbr, RecordID
