 CREATE PROCEDURE FCSetup_Options
AS
	-- Use explicit values until FCSetup record is available
	select	Cast(1 as smallint), 'Y', 'Y', 'F', 'R', Cast(1 as smallint)

        --Select	DfltWIPIntegrity,
        --		DfltBackFlushMtl,
        --		DfltBackFlushLbr,
	--		DfltScheduleOption,
        --		DfltScheduleMaterials,
        --		DfltAdjustCmpQty
	--From		FCSetup (NoLock)


