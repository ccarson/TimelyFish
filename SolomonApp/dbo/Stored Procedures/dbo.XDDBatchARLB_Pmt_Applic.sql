
CREATE PROCEDURE XDDBatchARLB_Pmt_Applic
   @LBBatNbr		varchar(10)

AS
   SELECT	*
   FROM		XDDBatchARLB X LEFT OUTER JOIN Customer C
		ON X.CustID = C.CustID
   WHERE	X.LBBatNbr = @LBBatNbr
   		and X.PmtApplicBatNbr = ''
		and X.PmtApplicRefNbr = ''
   ORDER BY	X.CpnyID, X.CuryID, X.CustID, X.RefNbr, X.LineNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_Pmt_Applic] TO [MSDSL]
    AS [dbo];

