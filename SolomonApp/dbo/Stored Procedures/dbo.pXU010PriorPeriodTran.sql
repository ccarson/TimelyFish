CREATE PROCEDURE pXU010PriorPeriodTran 
	-- CREATED BY: TJones
	-- CREATED ON: 8/19/05
	@CpnyId varchar (10),
	@PerPost varchar(6) 
	AS 
	DECLARE @RecCount AS float
	SET @RecCount = 0 

	SELECT @RecCount = @RecCount + IsNull(Count(*),0)
	FROM INTran i
	WHERE i.CpnyId = @CpnyId 
	AND ProjectID Not In('','0')
	AND i.TranType in ('II','RI') 
	AND i.Rlsed = 1 
	AND i.User5 = '' 
	AND i.PerPost < @PerPost

	SELECT @RecCount = @RecCount + IsNull(Count(*),0)
	FROM APTran a
	JOIN PurchOrd po ON a.PONbr = po.PONbr AND po.POType = 'DP'
	WHERE a.CpnyId = @CpnyId 
	AND a.ProjectID Not In('','0')
	AND a.TranType in ('VO','AD','AC')  -- Only vouchers or adjustments to vouchers 
	AND a.Rlsed = 1 
	AND a.User5 = '' 
	AND a.PerPost < @PerPost

	SELECT @RecCount = @RecCount + IsNull(Count(*),0)
	FROM POTran p
	JOIN POReceipt pr ON p.RcptNbr = pr.RcptNbr AND pr.Rlsed = 1
	WHERE p.CpnyId = @CpnyId 
	AND p.ProjectID Not In('','0')
	AND p.PurchaseType In('GN','GP')  -- limit to these two types, other should be handled elsewhere
	/* GN=Non-Inventory Goods GP=Goods For Project */
	AND p.User5 = '' 
	AND p.PerPost < @PerPost
	
	SELECT @RecCount
