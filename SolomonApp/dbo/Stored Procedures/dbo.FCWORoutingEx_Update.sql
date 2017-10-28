 create proc FCWORoutingEx_Update
	@WONbr			varchar( 16 ),
	@Task			varchar( 32 ),
	@UpdateLaborEstimate	smallint		-- -1 if True
AS

	-- Stub proc for now
	Select 0

	-- This proc will insert/update FCWORoutingEx table
	-- When SFC is installed, this stub proc will be replaced

	-- FCWORoutingEx
	-- Includes Estimates for:
	-- 	Direct Labor
	--	Other Direct Costs
	--	Fixed Labor Ovh
	--	Variable Labor Ovh
	--	Fixed Machine Ovh
	--	Variable Machine Ovh
	-- Also PJ tables, PJPTDROL, PJPTDSUM
	-- Queue time/Lot
	-- Move time/Lot
	-- Current Std Yield


