 CREATE PROCEDURE ADG_SOAddrSlsper_DefaultAll
	@custid char(15),
	@lupd_datetime smalldatetime,
	@lupd_prog char(8),
	@lupd_user char(10),
	@crtd_datetime smalldatetime,
	@crtd_prog char(8),
	@crtd_user char(10)
as
	begin transaction

	if exists( select custid from customer where custid = @custid ) begin

		-- Remove the old data.
		delete from
			soaddrslsper
		where	custid = @custid

		-- Insert the new data.
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
			0 as NoteID,		-- Don't copy notes
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
			adr.shiptoid as ShipToID,
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
		from	soaddress as adr, custslsper as csp
		where	adr.custid = csp.custid
		  and	adr.custid = @custid
	end

	commit transaction

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOAddrSlsper_DefaultAll] TO [MSDSL]
    AS [dbo];

