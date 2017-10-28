 create procedure DMG_Default_CommPct

	@ShipCustID	varchar(15),
	@ShipToID	varchar(10),
	@UserID		varchar(47),
	@SlsperID	varchar(10)

as
	declare @DfltSlsperMethod	varchar(1)
	declare @CommPct		float
	declare @RecCnt			integer
	declare @RecCnt1		integer

	-- get the default salesperson method
	select	@DfltSlsperMethod = DfltSlsperMethod
	from	SOSetup

	-- if the method is USER
	if @DfltSlsperMethod = 'B'
	begin
		-- get the count of records in the customer salesperson table that match the passed salesperson id
		select	@RecCnt = count(*)
		from	SOAddrSlsper
		where	CustID = @ShipCustID
		and	ShipToID = @ShipToID
		and	SlsperID = @SlsperID

		-- get the count of records in the user salesperson table that match the passed salesperson id
		select	@RecCnt1 = count(*)
		from	UserSlsper
		where	UserID = @UserID
		and	SlsperID = @SlsperID

		-- if the passed salesperson id is in the customer salesperson table
		if @RecCnt > 0
		begin
			-- get the commission percentage from the customer salesperson table
			select	@CommPct = CreditPct
			from	SOAddrSlsper
			where	CustID = @ShipCustID
			and	ShipToID = @ShipToID
			and	SlsperID = @SlsperID
		end
		else
		begin
			-- if the passed salesperson id is not in the customer salesperson
			-- table but is in the user salesperson table
			if @RecCnt1 > 0
			begin
				-- get the commission percentage from the user salesperson table
				select	@CommPct = CreditPct
				from	UserSlsper
				where	UserID = @UserID
				and	SlsperID = @SlsperID
			end
			else
			begin
				-- get the commission percentage from the salesperson table
				select	@CommPct = CmmnPct
				from	Salesperson
				where	SlsperID = @SlsperID
			end
		end
	end

	-- if the method is CUSTOMER
	if @DfltSlsperMethod = 'C'
	begin
		-- get the count of records in the customer salesperson table that match the passed salesperson id
		select	@RecCnt = count(*)
		from	SOAddrSlsper
		where	CustID = @ShipCustID
		and	ShipToID = @ShipToID
		and	SlsperID = @SlsperID

		-- if the passed salesperson id is in the customer salesperson table
		if @RecCnt > 0
		begin
			-- get the commission percentage from the customer salesperson table
			select	@CommPct = CreditPct
			from	SOAddrSlsper
			where	CustID = @ShipCustID
			and	ShipToID = @ShipToID
			and	SlsperID = @SlsperID
		end
		else
		begin
			-- get the commission percentage from the salesperson table
			select	@CommPct = CmmnPct
			from	Salesperson
			where	SlsperID = @SlsperID
		end
	end

	-- if the method is USER
	if @DfltSlsperMethod = 'U'
	begin
		-- get the count of records in the user salesperson table that match the passed salesperson id
		select	@RecCnt = count(*)
		from	UserSlsper
		where	UserID = @UserID
		and	SlsperID = @SlsperID

		-- if the passed salesperson id is in the user salesperson table
		if @RecCnt > 0
		begin
			-- get the commission percentage from the user salesperson table
			select	@CommPct = CreditPct
			from	UserSlsper
			where	UserID = @UserID
			and	SlsperID = @SlsperID
		end
		else
		begin
			-- get the commission percentage from the salesperson table
			select	@CommPct = CmmnPct
			from	Salesperson
			where	SlsperID = @SlsperID
		end
	end

	-- if the method is NO DEFAULT
	if @DfltSlsperMethod = 'X'
	begin
		-- get the commission percentage from the salesperson table
		select	@CommPct = CmmnPct
		from	Salesperson
		where	SlsperID = @SlsperID
	end
		-- return the commission percentage
	select @CommPct

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Default_CommPct] TO [MSDSL]
    AS [dbo];

