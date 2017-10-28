 create procedure DMG_ProcessQueue_Insert
	@ComputerName		varchar(21),
        @CpnyID			varchar(10),
        @CustID			varchar(15),
        @InvtID			varchar(30),
        @MaintMode		smallint,
	@ProcessCPSOff		smallint,
        @ProcessPriority	smallint,
        @ProcessType		varchar(5),
        @POLineRef		varchar(5),
        @PONbr			varchar(10),
        @PlanEntireItem		integer,
        @SiteID			varchar(10),
        @SOLineRef		varchar(5),
        @SOOrdNbr		varchar(15),
        @SOSchedRef		varchar(5),
        @SOShipperID		varchar(15),
        @SOShipperLineRef	varchar(5),
	@WOLineRef		varchar(5),
	@WONbr			varchar(16),
	@WOTask			varchar(32)

as
	--Rely on defaults to fill out the remaining columns
	insert into ProcessQueue(
		ComputerName,CpnyID, CustID, InvtID, MaintMode, ProcessCPSOff, ProcessPriority, ProcessType, POLineRef, PONbr,
		S4Future09, SiteID, SOLineRef, SOOrdNbr, SOSchedRef, SOShipperID, SOShipperLineRef, WOLineRef, WONbr, WOTask)
	values(
		@ComputerName, @CpnyID, @CustID, @InvtID, @MaintMode, @ProcessCPSOff, @ProcessPriority, @ProcessType, @POLineRef, @PONbr,
		@PlanEntireItem, @SiteID, @SOLineRef, @SOOrdNbr, @SOSchedRef, @SOShipperID, @SOShipperLineRef, @WOLineRef, @WONbr, @WOTask)

	if @@ROWCOUNT = 0
		return 0	--Failure
	else
		return 1	--Success


