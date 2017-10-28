 Create Procedure IRAddOnHand_SumQty @invtid varchar (30), @SiteId VarChar(10), @TodayDate smalldatetime, @TodayPlusLeadTime smalldatetime
   As
	SELECT SUM(ISNULL(QtyDesired, 0))
		FROM IRAddOnHand
	WHERE
		InvtID = @InvtID AND
		SiteID = @SiteID AND
		OnDate >= @TodayDate AND
		OnDate <= @TodayPlusLeadTime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRAddOnHand_SumQty] TO [MSDSL]
    AS [dbo];

