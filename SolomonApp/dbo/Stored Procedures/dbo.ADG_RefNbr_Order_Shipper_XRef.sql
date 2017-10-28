 CREATE PROCEDURE ADG_RefNbr_Order_Shipper_XRef
	@RefNbr		Varchar(10)
AS
	Declare @OrderCnt Float,
		@ShipperCnt Float
		Select @OrderCnt = Count(*) From SoHeader Where InvcNbr = @RefNbr
	Select @ShipperCnt = Count(*) From SoShipHeader Where InvcNbr = @RefNbr

	If @OrderCnt = 0 And @ShipperCnt = 0
	Begin
	   DELETE RefNbr WHERE	RefNbr = @RefNbr
	End


