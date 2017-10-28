
CREATE PROCEDURE XDDFile_Wrk_Cust_Total
	@EBFileNbr	varchar( 6 ),
   	@PmtCpnyID	varchar( 10 ),
   	@PmtCuryID	varchar( 4 ),
   	@CustID		varchar( 15 ),
   	@CashAcct	varchar( 10 ),
   	@CashSub	varchar( 24 )
AS
	SELECT 		coalesce(sum( ChkCuryAmt ), 0)
	FROM		XDDFile_Wrk (nolock)
	WHERE		FileType IN ('R', 'X')
			and EBFileNbr = @EBFileNbr
			and VchCpnyId = @PmtCpnyID 
			and VchCuryID = @PmtCuryID
			and VendId = @CustID
			and ChkAcct = @CashAcct
			and ChkSub = @CashSub
        		and RecSection = '20P' 
			and RecType = '10V'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_Cust_Total] TO [MSDSL]
    AS [dbo];

