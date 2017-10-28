 CREATE PROCEDURE p08990CheckAdjs AS
INSERT INTO WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)
SELECT v.custid, v.doctype, 50, v.origdocamt, v.docbal, v.SumOfAllAdjs, v.refnbr
  FROM vi_08990CompareAdjs v
 WHERE v.DocBalPlusAdjs <> v.origdocamt or v.curyDocBalPlusAdjs <> v.curyorigdocamt



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckAdjs] TO [MSDSL]
    AS [dbo];

