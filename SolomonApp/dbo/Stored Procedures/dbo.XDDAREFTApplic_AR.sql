
CREATE PROCEDURE XDDAREFTApplic_AR
	@CustID		varchar( 15 ),
	@DocType	varchar( 2 ),
	@RefNbr		varchar( 10 )
AS

	-- The order of the fields is important - it matches the app's buffer layout
	CREATE TABLE #TempTableOut
	(	BatNbr			char ( 10 )	NOT NULL,
    		RefNbr                  char ( 10 )	NOT NULL,
    		Status                  char ( 1 )	NOT NULL,
    		ApplyAmt   		float		NOT NULL,
    		DiscAmt			float		NOT NULL
	)

	-- Get Unreleased applications (ARTran)
	INSERT	INTO #TempTableOut
	(BatNbr, RefNbr, Status, ApplyAmt, DiscAmt)
	SELECT		A.BatNbr,
			A.RefNbr,
			B.Status,
			A.CuryTranAmt,
			A.CnvFact
	FROM		ARTran A (nolock) LEFT OUTER JOIN Batch B (nolock)
			ON A.BatNbr = B.BatNbr and B.Module = 'AR'
	WHERE		A.SiteID = @RefNbr
			and A.CostType = @DocType
			and A.CustID = @CustID
			and A.DRCR = 'U'
			and A.TranType IN ('PA', 'CM', 'PP')
	
	-- Get Released applications (APAdjust)
	INSERT	INTO #TempTableOut
	(BatNbr, RefNbr, Status, ApplyAmt, DiscAmt)
	SELECT		A.AdjBatNbr,
			A.AdjgRefNbr,
			B.Status,
			A.CuryAdjdAmt,
			A.CuryAdjdDiscAmt
	FROM		ARAdjust A (nolock) LEFT OUTER JOIN Batch B (nolock)
			ON A.AdjBatNbr = B.BatNbr and B.Module = 'AR'
	WHERE		A.AdjdRefNbr = @RefNbr
			and A.AdjdDocType = @DocType
			and A.CustID = @CustID

	SELECT		* FROM #TempTableOut
	ORDER BY	BatNbr DESC
	
