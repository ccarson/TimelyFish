CREATE PROCEDURE pXU010APTranHasProjButUser5Blank 
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	-- UPDATED ON: 8/19/05 -- changed filter per MTravous to be = only (not <=)
	-- This procedure is used by the program that generates intercompany
	-- entries - specifically for drop ship PO's that do not flow into INTran
	-- It includes only records that have ProjectID filled in with a non-zero value
	-- It filters for the specific company the user is logged into in Solomon and the
	-- peroid they have chosen.
	@CpnyId varchar (10),
	@PerPost varchar(6) 
	AS 
	SELECT a.*  
	FROM APTran a
	JOIN PurchOrd po ON a.PONbr = po.PONbr AND po.POType = 'DP'
	WHERE a.CpnyId = @CpnyId 
	AND a.ProjectID Not In('','0')
	AND a.TranType in ('VO','AD','AC')  -- Only vouchers or adjustments to vouchers 
	AND a.Rlsed = 1 
	AND a.User5 = '' 
	AND a.PerPost = @PerPost
	ORDER BY a.ProjectID, a.TaskID, a.Acct, a.Sub, a.PerPost, a.TranType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010APTranHasProjButUser5Blank] TO [MSDSL]
    AS [dbo];

