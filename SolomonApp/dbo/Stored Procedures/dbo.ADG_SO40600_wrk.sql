 create proc ADG_SO40600_wrk
	@ri_id		smallint

as

	Declare @CpnyID			varchar(10)
	Declare @ShipperID		varchar(15)
	Declare @LineRef		varchar(5)
	Declare @Cntr			smallint
	Declare @LotSerTrack		varchar(2)
	Declare @LotSerNbr		varchar(25)
	Declare @QtyShip		float
	Declare @RecCntr		int
	Declare @LotSerCntr		int
	Declare @SQLStr			varchar(255)

	-- Delete all records with the current ri_id out of SOPrintQueue.
	delete from SO40600_Wrk where ri_id = @ri_id

	-- Insert the initial records into the SO40600 work table for update.
	insert	into SO40600_Wrk
		( CpnyID, ShipperID, LineRef, WhseLoc, RI_ID, Cntr,
		LotSerNbr00, LotSerNbr01, LotSerNbr02, LotSerNbr03,
		LotSerNbr04, Qty00, Qty01, Qty02, Qty03, Qty04,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12 )
 	select 	distinct S.CpnyID, S.ShipperID, S.LineRef, '', @ri_id, 1,
		'', '', '', '', '', 0, 0, 0, 0, 0,
		'','',0,0,0,0,'','',0,0,'',''
	from	SOShipLot S
	join	SOPrintQueue P on S.ShipperID = P.ShipperID and S.CpnyID = P.CpnyID
	where	S.LotSerNbr <> ''
	and	P.RI_ID = @ri_id

	-- Open a cursor to scroll through the work table for updating
	-- the serial number values.
	Declare SO40600_wrk_cursor Insensitive Cursor For
		select 	RI_ID, CpnyID, ShipperID, LineRef, Cntr
		from 	SO40600_wrk
		where	RI_ID = @ri_id
		Open SO40600_wrk_cursor
	fetch next from SO40600_wrk_cursor into @RI_ID, @CpnyID, @ShipperID, @LineRef, @Cntr

	while (@@fetch_status = 0)
	begin

		Declare SOShipLot_cursor Cursor For
			select 	LotSerNbr, Sum(QtyShip)
			from	SOShipLot
			where 	CpnyID = @CpnyID
			  and	ShipperID = @ShipperID
			  and 	LineRef = @LineRef
			group by LotSerNbr

		Open SOShipLot_cursor
		fetch next from SOShipLot_cursor into @LotSerNbr, @QtyShip

		select @LotSerCntr = 0
		select @RecCntr = @Cntr

		while (@@fetch_status = 0)
		begin
			If @LotSerCntr <= 3
			begin
				select @SQLStr = 'update SO40600_Wrk set LotSerNbr0' + convert(varchar(1), @LotSerCntr) +
						 ' = ''' + Ltrim(Rtrim(@LotSerNbr)) + ''', Qty0' + convert(varchar(1), @LotSerCntr) +
						 ' = ' + convert(varchar(10), @QtyShip) +
						 ' where RI_ID = ' + convert(varchar(6), @RI_ID) +
						 ' and CpnyID = ''' + Rtrim(@CpnyID) +
						 ''' and ShipperID = ''' + Rtrim(@ShipperID) +
						 ''' and LineRef = ''' + Rtrim(@LineRef) +
						 ''' and Cntr = ' + convert(varchar(6), @RecCntr)
				exec (@SQLStr)

				select @LotSerCntr = @LotSerCntr + 1
			end
			else
			begin
				select @RecCntr = @RecCntr + 1
				select @LotSerCntr = 1

				insert	into SO40600_Wrk
					( CpnyID, ShipperID, LineRef, WhseLoc, RI_ID, Cntr,
					LotSerNbr00, LotSerNbr01, LotSerNbr02, LotSerNbr03,
					LotSerNbr04, Qty00, Qty01, Qty02, Qty03, Qty04,
					S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
					S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
					S4Future11, S4Future12 )
				values 	(@CpnyID, @ShipperID, @LineRef, '', @ri_id, @RecCntr,
					@LotSerNbr, '', '', '', '', @QtyShip, 0, 0, 0, 0,
					'','',0,0,0,0,'','',0,0,'','')


			end

			fetch next from SOShipLot_cursor into @LotSerNbr, @QtyShip
		end

		close SOShipLot_cursor
		deallocate SOShipLot_cursor

		fetch next from SO40600_wrk_cursor into @RI_ID, @CpnyID, @ShipperID, @LineRef, @Cntr
	end

	close SO40600_wrk_cursor
	deallocate SO40600_wrk_cursor
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SO40600_wrk] TO [MSDSL]
    AS [dbo];

