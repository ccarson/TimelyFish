 CREATE PROCEDURE PurchOrd_VendId_PONbr1
@parm1 varchar (15),
@parm2 varchar (10)
AS

SELECT * FROM PurchOrd

WHERE VendId = @parm1 AND
      PONbr LIKE @parm2 AND
      POtype IN ('OR', 'DP') AND
      Status IN ('M', 'O', 'P')

ORDER BY VendId, PONbr desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurchOrd_VendId_PONbr1] TO [MSDSL]
    AS [dbo];

