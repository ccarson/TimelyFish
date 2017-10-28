 Create Procedure Material_Upd41400 	@ReplenMethod VARCHAR(1),
					@FutureReplPol VARCHAR(1),
					@FutureReplDate SmallDateTime,
					@MatlType VARCHAR(10)
 AS
	Update SIMatlTypes set
		ReplMthd = @ReplenMethod,
		IRFuturePolicy = @FutureReplPol,
		IRFutureDate = @FutureReplDate
		WHERE
			MaterialType = @MatlType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Material_Upd41400] TO [MSDSL]
    AS [dbo];

