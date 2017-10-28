 CREATE Proc EDSOShipHeader_MarkSent @Parm1 varchar(15) As
Update EDSOShipHeader Set OutboundProcNbr = '0', LastEDIDate = GetDate() From EDSOShipHeader A, SOShipHeader B Where
A.ShipperId = B.ShipperId And A.CpnyId = B.CpnyId And B.CustId = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_MarkSent] TO [MSDSL]
    AS [dbo];

