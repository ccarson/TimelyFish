 CREATE Proc EDLogLabelPrintEvent @CpnyId varchar(10), @Descr varchar(30), @OrdNbr varchar(15), @ShipperId varchar(15), @UserId varchar(10)
As

set nocount on

declare @invcnbr varchar(15)
select @invcnbr = space(15)
if (@cpnyid != '' and @ordnbr != '')
   select @invcnbr = isnull(invcnbr, space(15)) from soheader where cpnyid = @cpnyid and ordnbr = @ordnbr

if (@cpnyid != '' and @shipperid != '')
   select @invcnbr = isnull(invcnbr, space(15)) from soshipheader where cpnyid = @cpnyid and shipperid = @ShipperId

insert soevent(CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,Descr, EventDate, EventTime, EventType, InvcNbr, LUpd_DateTime, LUpd_Prog, LUpd_User,NoteID, OrdNbr, ProgID,
S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
ShipperID, User1, User10, User2, User3, User4, User5, User6, User7, User8, User9, UserID)
select @CpnyId, getdate(), '', '', @Descr, getdate(), getdate(),'SLAB', @invcnbr, getdate(), '', '', 0, @OrdNbr, '50405',
'', '', 0, 0, 0, 0,'', '', 0, 0, '', '',
@ShipperId, '', '', '', '', '', 0, 0, '', '', '', @UserId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLogLabelPrintEvent] TO [MSDSL]
    AS [dbo];

