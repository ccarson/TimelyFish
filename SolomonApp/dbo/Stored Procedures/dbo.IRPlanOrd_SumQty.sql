 Create Procedure IRPlanOrd_SumQty @invtid varchar (30), @SiteId VarChar(10)
   As
	SELECT SUM(ISNULL(PlanQty, 0))
		FROM IRPlanOrd
	WHERE
		InvtID = @InvtID AND
		SiteID = @SiteID AND
		Status = 'FI'


