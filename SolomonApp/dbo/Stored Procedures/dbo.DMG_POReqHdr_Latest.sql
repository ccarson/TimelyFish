 Create procedure DMG_POReqHdr_Latest

	@ReqNbr varchar(15)
as

	Select	*
	From	POReqHdr
	Where	ReqNbr = @ReqNbr
	and	ReqCntr in (
			Select	MAX(Convert(Numeric,ReqCntr))
			From	POReqHdr
			Where	ReqNbr = @ReqNbr
			)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


