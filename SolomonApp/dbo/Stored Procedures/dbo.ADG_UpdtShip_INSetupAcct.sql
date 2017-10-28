 create proc ADG_UpdtShip_INSetupAcct
as
	select	APClearingAcct,
		APClearingSub,
		ARClearingAcct,
		ARClearingSub,
--		InTransitAcct,
--		InTransitSub
		INClearingAcct,	-- temp
		INClearingSub	-- temp

	from	INSetup

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


