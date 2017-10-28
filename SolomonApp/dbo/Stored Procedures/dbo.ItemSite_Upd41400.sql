 Create Procedure ItemSite_Upd41400 	@ReplenMethod VARCHAR(1),
					@FutureReplPol VARCHAR(1),
					@FutureReplDate SmallDateTime,
					@InvtID VARCHAR(30),
					@SiteID VARCHAR(10)
 AS
	Update ItemSite set
		ReplMthd = @ReplenMethod,
		IRFuturePolicy = @FutureReplPol,
		IRFutureDate = @FutureReplDate
		WHERE
			InvtID = @InvtID
			AND SiteID = @SiteID


