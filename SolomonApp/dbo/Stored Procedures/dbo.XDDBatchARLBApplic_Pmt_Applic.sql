
CREATE PROCEDURE XDDBatchARLBApplic_Pmt_Applic
   @PmtRecordID		int

AS
   SELECT	*
   FROM		XDDBatchARLBApplic X LEFT OUTER JOIN ARDoc A
		ON X.CustID = A.CustID and X.RefNbr = A.RefNbr and X.DocType = A.DocType
   WHERE	X.PmtRecordID = @PmtRecordID
   		and (X.ApplyAmount + X.DiscApplyAmount) > 0
   ORDER BY	X.LineNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLBApplic_Pmt_Applic] TO [MSDSL]
    AS [dbo];

