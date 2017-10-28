 Create Procedure DMG_SOLine_InvtID_OrdNbr
	@CpnyID varchar(10),
	@InvtID varchar(30),
	@OrdNbr varchar(15)
as

	Select	*
	From	vp_SOLinePO
	Where	CpnyID = @CpnyID
	And 	InvtID = @InvtID
	And		OrdNbr LIKE @OrdNbr
	Order by CpnyID, InvtID, OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOLine_InvtID_OrdNbr] TO [MSDSL]
    AS [dbo];

