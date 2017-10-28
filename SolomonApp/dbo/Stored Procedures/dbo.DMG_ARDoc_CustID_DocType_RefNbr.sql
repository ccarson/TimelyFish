 create procedure DMG_ARDoc_CustID_DocType_RefNbr
	@CustID varchar(15),
	@DocType varchar(2),
	@RefNbr varchar(10)
	as

	Select 	Count(*)
	from 	Ardoc
	where	ardoc.custid = @CustID and
	        ardoc.doctype = @DocType and
		ardoc.refnbr = @RefNbr

-- Copyright 2001 by Solomon Software, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ARDoc_CustID_DocType_RefNbr] TO [MSDSL]
    AS [dbo];

