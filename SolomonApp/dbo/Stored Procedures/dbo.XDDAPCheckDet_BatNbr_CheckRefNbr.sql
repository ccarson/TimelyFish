CREATE PROCEDURE XDDAPCheckDet_BatNbr_CheckRefNbr
   @BatNbr       varchar(10),
   @CheckRefNbr  varchar(10)

AS
   Select        * from APCheckDet
   WHERE         BatNbr = @BatNbr and
                 CheckRefNbr = @CheckRefNbr
   ORDER BY      BatNbr, CheckRefNbr, RecordID
