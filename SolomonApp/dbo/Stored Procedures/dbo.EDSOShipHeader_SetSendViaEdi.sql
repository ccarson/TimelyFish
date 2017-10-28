 CREATE PROCEDURE EDSOShipHeader_SetSendViaEdi @ShipperId varchar(15), @CpnyId varchar(10) AS

Declare @SendViaEDI smallint
Declare @CustId varchar(15)

Select @CustId = Custid from SOShipHeader where ShipperId = @ShipperId and CpnyId = @CpnyId

Select @SendViaEDI = 0

Select @SendViaEDI = Count(*) from EDOutbound where CustId = @CustId and Trans in ('810','880')

Update EDSOShipHeader set SendViaEDI = @SendViaEDI where ShipperId = @ShipperId and CpnyId = @CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_SetSendViaEdi] TO [MSDSL]
    AS [dbo];

