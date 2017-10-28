 create procedure DMG_Check_PreNumInv_SOStepSeq

	@CpnyID	varchar(10)
as

Declare @SOTypeID		varchar(4)
Declare @PrintInvoiceSeq	varchar(4)
Declare @UpdateShipSeq		varchar(4)
Declare @ReturnValue		bit

select @ReturnValue = 0

Declare SOTypeIDCursor Cursor for Select distinct SOTypeID from SOStep where CpnyID = @CpnyID
open SOTypeIDCursor
fetch next from SOTypeIDCursor into @SOTypeID

while (@@fetch_status = 0)
begin
		select  @UpdateShipSeq = ''
	select 	@PrintInvoiceSeq = ''

	select 	@UpdateShipSeq = Seq
	from 	sostep
	where 	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID
	  and   EventType = 'USHP'

	select 	@PrintInvoiceSeq = Seq
	from 	sostep
	where 	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID
	  and   EventType = 'PINV'
		If @UpdateShipSeq < @PrintInvoiceSeq and @UpdateShipSeq > 0 and @PrintInvoiceSeq > 0
		select @ReturnValue = 1

	fetch next from SOTypeIDCursor into @SOTypeID
end

close SOTypeIDCursor
deallocate SOTypeIDCursor

select @ReturnValue

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Check_PreNumInv_SOStepSeq] TO [MSDSL]
    AS [dbo];

