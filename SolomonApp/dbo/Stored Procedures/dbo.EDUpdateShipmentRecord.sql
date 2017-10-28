 CREATE PROCEDURE EDUpdateShipmentRecord @inBolNbr varchar(20), @inShipperID varchar(15), @inCpnyID varchar(10) AS
-- Expect EDShipTicket record to exist, will  modify the BOL nbr to be the InBolNbr
-- If previous BOL existed, will validate that the old BOL does exist, and if no more Shippers, will remove.  If other shippers are on the old BOL,
--    then will call the Re-Calc routine to fix sums
     Declare @InternalError integer
     Declare @OldBolNbr varchar(20)
     Declare @NbrRecsLeft float
set nocount on
 -- Determine if old BOL exists for this ticket, and is different from new BOL nbr to use
    select @OldBolNbr = BolNbr  from EDShipTicket where shipperid = @inShipperID and CpnyID = @inCpnyID and BolNbr <> @inBolNbr
     if isnull(@OldBolNbr,'~') <> '~'
     Begin
-- Old record exists, must do things to it
--     ' Can only have one BOL for new item.
         Delete from  EDShipTicket where shipperid = @inShipperID and CpnyID = @inCpnyID and BolNbr <> @inBolNbr
--     ' Now  update containers
-- QN 02/12/2003, DE 231424 - move the Update EDContainer to outside of the IF to update no matter what
--         Update EDcontainer set bolnbr = @inBolNbr where shipperid = @inShipperID and CpnyID = @inCpnyID
         Select @NbrRecsLeft = Count(*) from EDShipTicket where bolnbr = @OldBolNbr
        if @NbrRecsLeft >= 1
        begin
--            ' If still at least one ship left, then recalc
                Execute EDRecalcBOLInfo @OldBolNbr
        end
     Else
-- Old record Does not exist, update current
        begin
--         ' Else remove old ship record, that has no recs in it
              delete from EDShipment where bolnbr = @OldBolNbr

        end
     end

  -- QN 02/12/2003, DE 231424 - update BOL in the EDContainer
  Update EDcontainer set bolnbr = @inBolNbr where shipperid = @inShipperID and CpnyID = @inCpnyID

  -- Update the BOL field on the edsoshipheader record
  Update EDSOShipHeader Set BOL = @inBOLNbr Where CpnyId = @inCpnyId And ShipperId = @inShipperId
set nocount off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDUpdateShipmentRecord] TO [MSDSL]
    AS [dbo];

