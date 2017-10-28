CREATE PROCEDURE pXU010POTranHasProjButUser5Blank 
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	-- UPDATED ON: 8/19/05 -- changed filter per MTravous to be = only (not <=)
	-- This procedure is used by the program that generates intercompany
	-- entries - specifically for "Goods for Project" and "Non-Inventory Goods" PO lines 
	-- that do not flow into INTran
	-- It includes only records that have ProjectID filled in with a non-zero value
	-- It filters for the specific company the user is logged into in Solomon and the
	-- peroid they have chosen.
	@CpnyId varchar (10),
	@PerPost varchar(6) 
	AS 
	SELECT p.*  
	FROM POTran p
	JOIN POReceipt pr ON p.RcptNbr = pr.RcptNbr AND pr.Rlsed = 1
	WHERE p.CpnyId = @CpnyId 
	AND p.ProjectID Not In('','0')
	AND p.PurchaseType In('GN','GP')  -- limit to these two types, other should be handled elsewhere
	/* GN=Non-Inventory Goods GP=Goods For Project */
	AND p.User5 = '' 
	AND p.PerPost = @PerPost
	ORDER BY p.ProjectID, p.TaskID, p.Acct, p.Sub, p.PerPost, p.TranType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010POTranHasProjButUser5Blank] TO [MSDSL]
    AS [dbo];

