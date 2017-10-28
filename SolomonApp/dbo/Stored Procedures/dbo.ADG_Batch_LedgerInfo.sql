 create proc ADG_Batch_LedgerInfo
	@LedgerID	varchar(10)
as
	select		BalanceType,
			BaseCuryID
	from		Ledger
	where		LedgerID = @LedgerID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


