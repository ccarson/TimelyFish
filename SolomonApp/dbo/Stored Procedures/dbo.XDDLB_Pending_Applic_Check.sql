
CREATE PROCEDURE XDDLB_Pending_Applic_Check
	@CuryID			varchar( 4 ),
	@CuryRate		float,
	@CustID			varchar( 15 ),
	@RefNbr			varchar( 10 ),
	@ReturnSelect		smallint,
	@AllSame		tinyint OUTPUT
AS	

	Declare @DocType	varchar( 2 )

	SELECT	@DocType = 'IN'
		
	SELECT	@DocType
	FROM	ARDoc (nolock)
	WHERE	CustID = @CustID
		and RefNbr = @RefNbr
		and DocType IN ('IN', 'DM', 'FI')
		
	SET @AllSame = 1
	
	-- Do we need to consider company here?
	
	-- Check all Outstanding LB batches for pending txns that don't match CuryID and CuryRate
	if Exists(SELECT * FROM	XDDBatchARLBApplic A (nolock) LEFT OUTER JOIN XDDBatchARLB L (nolock)
				ON A.LBBatNbr = L.LBBatNbr and A.CustID = L.CustID and A.PmtRecordID = L.RecordID LEFT OUTER JOIN XDDBatch B (nolock)
				ON A.LBBatNbr = B.BatNbr and B.FileType = 'L'
			WHERE	A.CustID = @CustID
				and A.DocType = @DocType
				and A.RefNbr = @RefNbr
				and L.PmtApplicBatNbr = ''	-- Not Releaeed
				and L.PmtApplicRefNbr = ''	-- Not Released
				and (B.CuryID <> @CuryID or B.CuryRate <> @CuryRate)	-- Curr Values don't match
		)
		SET @AllSame = 0
		
	-- Check all Outstanding A/R batches (On Hold/Balanced) that don't match CuryID and CuryRate
	if @AllSame = 1
		If Exists(SELECT * FROM	ARDoc A (nolock) LEFT OUTER JOIN Batch B (nolock)
					ON A.BatNbr = B.BatNbr and B.Module = 'AR'
				WHERE	B.EditScrnNbr = '08030'
					and B.Status In ('B', 'H')
					and A.CustID = @CustID
					and A.DocType = @DocType
					and A.RefNbr = @RefNbr
					and (B.CuryID <> @CuryID or B.CuryRate <> @CuryRate)	-- Curr Values don't match
			)
			SET @AllSame = 0

			
	if @ReturnSelect = 1		
		SELECT	@AllSame
			

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLB_Pending_Applic_Check] TO [MSDSL]
    AS [dbo];

