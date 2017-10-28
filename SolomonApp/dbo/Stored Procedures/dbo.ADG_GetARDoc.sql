 CREATE PROCEDURE ADG_GetARDoc
	@CustID   char(15),
	@DocType  char(15),
	@RefNbr   char(10),
	@BatNbr   char(10),
	@BatSeq   int
AS

	select
		*
	from
		ARDoc
	where
		CustID = @CustID
	and
		DocType = @DocType
	and
		RefNbr = @RefNbr
	and
		BatNbr = @BatNbr
	and
		BatSeq = @BatSeq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GetARDoc] TO [MSDSL]
    AS [dbo];

