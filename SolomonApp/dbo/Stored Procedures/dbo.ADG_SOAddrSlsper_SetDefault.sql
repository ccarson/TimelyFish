 CREATE PROCEDURE ADG_SOAddrSlsper_SetDefault
	@custid varchar(15),     -- Customer ID
	@shiptoid varchar(10),   -- SOAddress ID
	@lupd_datetime smalldatetime,
	@lupd_prog char(8),
	@lupd_user char(10),
	@crtd_datetime smalldatetime,
	@crtd_prog char(8),
	@crtd_user char(10)
as
	-- If the shiptoid is valid and there are no records in soaddrslsper
	-- for this customer and ship-to, then insert a default set of records
	-- from custslsper.

	begin transaction

	if exists( select shiptoid from soaddress where custid = @custid and shiptoid = @shiptoid )
	  and not exists( select custid from soaddrslsper (UPDLOCK)
				where custid = @custid and shiptoid = @shiptoid )
	begin

		-- Insert the new data
		insert into
			soaddrslsper
		select
			csp.CreditPct,
			@crtd_datetime as Crtd_DateTime,
			@crtd_prog as Crtd_Prog,
			@crtd_user as Crtd_User,
			csp.CustID,
			@lupd_datetime as LUpd_DateTime,
			@lupd_prog as LUpd_Prog,
			@lupd_user as LUpd_User,
			0 as NoteID, -- Dont copy notes
			'',
			'',
			0,
			0,
			0,
			0,
			convert(smalldatetime,'12:00'),
			convert(smalldatetime,'12:00'),
			0,
			0,
			'',
			'',
			@shiptoid as ShipToID,
			csp.SlsPerID,
			csp.User1,
			csp.User10,
			csp.User2,
			csp.User3,
			csp.User4,
			csp.User5,
			csp.User6,
			csp.User7,
			csp.User8,
			csp.User9,
			null as tstamp
		from	custslsper as csp
		where	csp.custid = @custid

	end

	commit transaction

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOAddrSlsper_SetDefault] TO [MSDSL]
    AS [dbo];

