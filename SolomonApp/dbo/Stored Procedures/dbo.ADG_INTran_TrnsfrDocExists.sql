 create proc ADG_INTran_TrnsfrDocExists
	@TrnsfrDocNbr	varchar(10)
as
	declare		@DocCount	integer
	declare		@DocExists	smallint

	select		@DocCount = count(*)
	from		TrnsfrDoc
	where		TrnsfrDocNbr = @TrnsfrDocNbr

	if (@DocCount > 0)
		select @DocExists = 1
	else
		select @DocExists = 0

	select @DocExists

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_TrnsfrDocExists] TO [MSDSL]
    AS [dbo];

