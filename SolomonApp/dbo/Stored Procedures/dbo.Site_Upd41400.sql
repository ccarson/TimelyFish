 Create Procedure Site_Upd41400 	@ReplenMethod VARCHAR(1),
					@FutureReplPol VARCHAR(1),
					@FutureReplDate SmallDateTime,
					@SiteID VARCHAR(10)
 AS
	Update Site set
		ReplMthd = @ReplenMethod,
		IRFuturePolicy = @FutureReplPol,
		IRFutureDate = @FutureReplDate
		WHERE
			SiteID = @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Site_Upd41400] TO [MSDSL]
    AS [dbo];

