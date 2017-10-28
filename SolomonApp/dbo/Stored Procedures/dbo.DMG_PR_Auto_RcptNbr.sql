 CREATE procedure DMG_PR_Auto_RcptNbr(
	@CpnyID   char(10),
	@NumTries smallint
)AS
	declare @Status	smallint
	declare	@DocID	char(10)
	declare @Width	smallint

	EXEC DMG_PR_Auto_RcptNbr_OP @CpnyID, @NumTries, @Status OUTPUT, @DocID OUTPUT, @Width OUTPUT

	-- Return the parameters as a result set
	select Status = @Status, DocID = @DocID, Width = @Width

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_Auto_RcptNbr] TO [MSDSL]
    AS [dbo];

