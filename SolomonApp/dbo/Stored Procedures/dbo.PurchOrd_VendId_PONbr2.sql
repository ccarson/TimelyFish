 CREATE PROCEDURE PurchOrd_VendId_PONbr2
@parm1 varchar (15),
@parm2 varchar (10)
AS

SELECT distinct PurchOrd.PONbr,PurchOrd.POType,PurchOrd.Status,PurchOrd.PODate, PurchOrd.VendID
FROM PurchOrd
WHERE Purchord.POtype IN ('OR', 'DP') AND
      Purchord.Status IN ('M', 'O', 'P') AND
	  purchord.VouchStage IN ('N', 'P') AND
	  purchord.VendId LIKE @parm1 AND
      purchord.PONbr LIKE @parm2
ORDER BY purchord.VendId, purchord.PONbr desc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_VendId_PONbr2] TO [MSDSL]
    AS [dbo];

