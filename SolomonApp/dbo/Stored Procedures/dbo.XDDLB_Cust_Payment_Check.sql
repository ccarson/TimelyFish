
CREATE PROCEDURE XDDLB_Cust_Payment_Check
	@LBBatNbr	varchar( 10 )
AS
	
	SELECT	L1.*			-- .refnbr, L1.amount, L1.custid, L1.InvcNbr, L1.InvApplyAmt 
	FROM	xddbatcharlb L1 (nolock) 
	WHERE	L1.lbbatnbr = @LBBatNbr
		and exists (Select * from XDDBatchARLB L2 (nolock) 
 				WHERE 	L2.LBBatNbr = L1.LBBatNbr 
  					and L2.CustID <> L1.CustID 
  					and L2.Amount = L1.Amount 
  					and L2.RefNbr = L1.RefNbr) 
 	ORDER BY L1.RefNbr, L1.CustID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLB_Cust_Payment_Check] TO [MSDSL]
    AS [dbo];

