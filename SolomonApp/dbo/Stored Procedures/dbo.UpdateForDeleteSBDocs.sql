 CREATE PROC UpdateForDeleteSBDocs @BatNbr VARCHAR(10), @CustID VARCHAR(15), @TranType VARCHAR(2),
                                  @OrigDocNbr VARCHAR(10), @RefNbr VARCHAR(10), @SBBalance FLOAT
AS
/* Since we are deleting the SB Document; we need to add the Document back to the existing U Trans. */
Declare @SiteID  VARCHAR(10), @CostType VARCHAR(2)

SELECT @SiteID = SiteID, @CostType = CostType
  FROM ARTRAN
 WHERE BATNBR = @BatNbr
   AND CUSTID = @CustID
   AND REFNBR = @REFNBR
   AND Trantype = 'SB'
   AND DRCR = 'U'
   AND RecordID = (SELECT MAX(RECORDID)
                    FROM ARTRAN
                   WHERE BATNBR = @BatNbr
                     AND CUSTID = @CustID
                     AND REFNBR = @REFNBR
                     AND Trantype = 'SB'
                     AND DRCR = 'U')

UPDATE ARTran SET CuryTxblAmt00 = CuryTxblAmt00 + @SBBalance
 WHERE BatNbr = @BatNbr AND CustID = @CustID
   AND Refnbr = @OrigDocNbr AND CostType = @CostType AND SiteID = @SiteID
   AND DrCr = 'U' AND TranType IN ('PA','PP','CM')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdateForDeleteSBDocs] TO [MSDSL]
    AS [dbo];

