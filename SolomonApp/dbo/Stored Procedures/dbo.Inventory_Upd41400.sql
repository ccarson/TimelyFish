 Create Procedure Inventory_Upd41400 	@ReplenMethod VARCHAR(1),
					@FutureReplPol VARCHAR(1),
					@FutureReplDate SmallDateTime,
					@InvtID VARCHAR(30)
 AS
	Update Inventory set
		ReplMthd = @ReplenMethod,
		IRFuturePolicy = @FutureReplPol,
		IRFutureDate = @FutureReplDate
		WHERE
			InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_Upd41400] TO [MSDSL]
    AS [dbo];

