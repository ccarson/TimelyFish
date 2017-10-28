 CREATE PROCEDURE DMG_CheckCurrentPOReqDet
	@HeaderReqNbr varchar(10),
	@HeaderReqCntr varchar(2),
	@DetLineNbr smallint,
	@DetReqCntr varchar(2)
	AS

	If @DetReqCntr = (select max(Convert(int, POReqDet.reqcntr))
			from 	POReqDet
			where 	Convert(int, POReqDet.reqcntr) <= Convert(int, @HeaderReqCntr)
			  and 	POReqDet.ReqNbr = @HeaderReqNbr
			  and 	POReqDet.LineNbr = @DetLineNbr )
		select 1
	Else
		select 0

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


