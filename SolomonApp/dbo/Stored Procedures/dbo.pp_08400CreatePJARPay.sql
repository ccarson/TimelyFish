 CREATE PROCEDURE pp_08400CreatePJARPay @UserAddress VARCHAR(21),
                                       @Sol_User VARCHAR(10),
                                       @CRResult INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

DECLARE @ProgID CHAR (8)

SELECT @ProgID = '08400'

/********* for payment applications **********/
INSERT PJARPay (Applied_Amt, Check_Refnbr, Crtd_Datetime, Crtd_Prog, Crtd_User,
                CustId, Discount_Amt, DocType, Invoice_Refnbr, Invoice_Type,
                Lupd_DateTime, Lupd_Prog, Lupd_User, PJT_Entity, Project, Status)

SELECT j.AdjAmt, j.AdjgRefnbr, GETDATE(), @ProgID, j.Crtd_User,
       j.Custid, j.AdjDiscAmt, j.AdjgDocType, j.AdjdRefNbr, j.AdjdDocType,
       GETDATE(), @ProgID, j.Lupd_User, '', '', '1'
  FROM WrkRelease w (NOLOCK) JOIN ARAdjust j (NOLOCK)
                               ON  w.Batnbr = j.AdjBatnbr
                             JOIN ARDoc i (NOLOCK)
                               ON j.Custid = i.Custid AND j.AdjdDocType = i.DocType
                              AND j.AdjdRefNbr = i.RefNbr AND i.PC_Status = '1'
                              AND j.AdjgDocType IN ('PA', 'PP', 'SB')
 WHERE w.UserAddress = @UserAddress AND w.Module = 'AR'
 IF @@ERROR < > 0 GOTO ABORT

SELECT @CRResult = 1
GOTO FINISH

ABORT:
SELECT @CRResult = 0

FINISH:


