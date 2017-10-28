 create procedure ADG_X_CancelBackorder
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)
as
	declare	@ShipCmplt	smallint,
		@Insuff_Qty	smallint,
		@Today		smalldatetime

	-- Get the current date.
	select	@Today = getdate()

	-- Get the 'ship complete' setting from the order.
	select	@Shipcmplt = ShipCmplt
	from	SOHeader
	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr

	-- Cancel backorder when 'ship complete' is set to 'Partially Ship-Cancel Remainder'. This
	-- is accomplished by closing the order if any partially shipped lines are found.
	if @ShipCmplt = 3
	begin
		select	@Insuff_Qty = 0

		-- Check if there are
	        select	@Insuff_Qty = count(o.LineRef)
		from	SOLine o
		left outer join SOShipLine s
                on	o.CpnyID = s.CpnyID
		and	o.OrdNbr = s.OrdNbr
		and	o.LineRef = s.OrdLineRef
		and	s.ShipperID = @ShipperID
		where	o.CpnyID = @CpnyID
		and	o.OrdNbr = @OrdNbr
		and	(o.QtyOrd > s.QtyShip or s.ShipperID is null)

		if @Insuff_Qty > 0
		begin
			-- Close the order to prevent further shipments.
			update	SOHeader
			set	Status = 'C', NextFunctionID = '', NextFunctionClass = '', LUpd_DateTime = @Today, LUpd_Prog = 'SQL'
			where	CpnyID = @CpnyID
			and	OrdNbr = @OrdNbr

			-- Close the order line(s) to prevent further shipments.
			update	SOLine
			set	CancelDate = @Today, Status = 'C', LUpd_DateTime = @Today, LUpd_Prog = 'SQL'
			where	CpnyID = @CpnyID
			and	OrdNbr = @OrdNbr

			-- Close the order schedule(s) to prevent further shipments.
			update	SOSched
			set	Status = 'C', LUpd_DateTime = @Today, LUpd_Prog = 'SQL'
			where	CpnyID = @CpnyID
			and	OrdNbr = @OrdNbr

			-- Create the 'Modified' order event for the order.
			exec ADG_SOEvent_Create @CpnyID, '', 'MORD', @OrdNbr, 'SQL', '', 'SQL'

			-- Clear any 'No Ship Log' entries for the order.
			exec ADG_SONoShip_Delete @CpnyID, @OrdNbr

			-- Queue a planning request for the sales order.
			insert	ProcessQueue
				(CpnyID,CreateShipper,Crtd_DateTime,Crtd_Prog,Crtd_User,CustID,InvtID,LUpd_DateTime,LUpd_Prog,LUpd_User,
				MaintMode,NoteID,POLineRef,PONbr,ProcessAt,ProcessPriority,ProcessType,
				S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,
				S4Future09,S4Future10,S4Future11,S4Future12,SiteID,SOLineRef,SOOrdNbr,SOSchedRef,
				SOShipperID,SOShipperLineRef,User1,User10,User2,User3,User4,User5,User6,User7,User8,User9)
			values	(@CpnyID,0,@Today,'SQL','SQL','','',@Today,'SQL','SQL',
				0,0,'','',@Today,150,'PLNSO',
				'','',0.0,0.0,0.0,0.0,'1900-01-01','1900-01-01',
				0,0,'','','','',@OrdNbr,'',
				'','','','1900-01-01','','','',0.0,0.0,'','','1900-01-01')

			-- Queue a shipper creation request (this may not be necessary, but it
			-- emulates the way the screen currently works).
			exec ADG_ProcessMgr_QueueSOSh @CpnyID, @OrdNbr

			-- Queue an order processing request for the order.
                	insert	ProcessQueue
				(CpnyID,CreateShipper,Crtd_DateTime,Crtd_Prog,Crtd_User,CustID,InvtID,LUpd_DateTime,LUpd_Prog,LUpd_User,
				MaintMode,NoteID,POLineRef,PONbr,ProcessAt,ProcessPriority,ProcessType,
				S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,
				S4Future09,S4Future10,S4Future11,S4Future12,SiteID,SOLineRef,SOOrdNbr,SOSchedRef,
				SOShipperID,SOShipperLineRef,User1,User10,User2,User3,User4,User5,User6,User7,User8,User9)
			values	(@CpnyID,0,@Today,'SQL','SQL','','',@Today,'SQL','SQL',
				0,0,'','',@Today,155,'PRCSO',
				'','',0.0,0.0,0.0,0.0,'1900-01-01','1900-01-01',
				0,0,'','','','',@OrdNbr,'',
				'','','','1900-01-01','','','',0.0,0.0,'','','1900-01-01')
		end
	end

	-- Return 'NEXT', meaning that the shipper should advance to
	-- the next step in the order cycle.
	select	'Status' = 'NEXT',
		'Descr'  = convert(varchar(30), '')


