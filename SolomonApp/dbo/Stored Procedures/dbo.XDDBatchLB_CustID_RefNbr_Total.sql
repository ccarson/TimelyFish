
CREATE PROCEDURE XDDBatchLB_CustID_RefNbr_Total
   	@LBBatNbr	varchar( 10 ),
	@CustID		varchar( 15 ),
   	@RefNbr		varchar( 10 ),
   	@DecPl		smallint

AS

	SELECT 	Coalesce( Sum( Round(Amount, @DecPl) ), 0)
	FROM 	XDDBatchARLB L 
	WHERE	L.LBBatNbr = @LBBatNbr
		and L.CustID = @CustID
		and L.RefNbr = @RefNbr
   		and L.PmtApplicBatNbr = '' 
   		and L.PmtApplicRefNbr = ''

--	SELECT 	Coalesce( Sum( Round(Amount, @DecPl) ), 0)
--	FROM 	XDDBatchARLB L (nolock) LEFT OUTER JOIN Batch B (nolock)
--		ON L.PmtApplicBatNbr = B.BatNbr and 'AR' = B.Module
--	WHERE	L.LBBatNbr = @LBBatNbr
--		and L.CustID = @CustID
--		and L.RefNbr = @RefNbr
-- 		and L.PmtApplicBatNbr = '' 
--		and L.PmtApplicRefNbr = ''
   		-- ) or 
   		--     (L.PmtApplicBatNbr <> '' and L.PmtApplicRefNbr <> '') and B.Status = 'V')


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchLB_CustID_RefNbr_Total] TO [MSDSL]
    AS [dbo];

