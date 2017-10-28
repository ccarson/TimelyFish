 Create Proc ED810LineItem_AllLines
	@CpnyId varchar(10),
	@EDIInvId varchar(10),
	@LineNbrBeg smallint,
	@LineNbrEnd smallint
As
	Select *
	From ED810LineItem
	Where 	CpnyId = @CpnyId And
		EDIInvId = @EDIInvId And
		LineNbr Between @LineNbrBeg And @LineNbrEnd
	Order By CpnyId, EDIInvId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810LineItem_AllLines] TO [MSDSL]
    AS [dbo];

