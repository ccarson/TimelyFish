 create proc SCM_OrderTypeGeneratesPOs
	@CpnyID			varchar(10),
	@SOTypeID		varchar(4)
as

	SELECT	Count(*)
	FROM	SOSTEP
	WHERE	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID
	  and	FunctionID = '6040000'



