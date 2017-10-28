 CREATE Proc EDConfirm_SHShipHeaderInsert @CpnyId varchar(10), @ShipperId varchar(15), @FreightCost float
As
	DECLARE @ShipDateAct smalldatetime
		Delete From SHShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId
	Delete From SHShipPack Where CpnyId = @CpnyId And ShipperId = @ShipperId

	-- DE 232204 - Sys Msg 515 - Cannot insert NULL into SHShipHeader.ShipDateAct
	Select @ShipDateAct = ShipDateAct from SOShipHeader Where CpnyID = @CpnyId AND ShipperID = @ShipperId

	-- QN 05/10/2002, DE 229388 - populate SHShipHeader.ShipDateAct with SOShipHeader.ShipDateAct
	Insert Into SHShipHeader
		Values(@CpnyId,GetDate(),' ',' ',GetDate(),' ',' ',' ',' ',0,
			0,0,0,'01-01-1900','01-01-1900',0,0,' ',' ',@ShipDateAct,
			@ShipperId,1,0,' ',0,' ',' ',' ',
			0,0,' ',' ','01-01-1900',' ',DEFAULT)

	Insert Into SHShipPack
		Values (@FreightCost,'00001','',0,0,'',@CpnyId,getdate(), '', '',' ',0,0,getdate(), '', '',0,0,' ',' ',' ',' ',0,
			0,0,0,'01-01-1900','01-01-1900',0,0,' ', ' ',@ShipperId, ' ','',' ','01-01-1900',' ',' ',' ',0,
			0,' ',' ','01-01-1900',0, 0,DEFAULT)

	EXEC ADG_ProcessMgr_QueueUpdASMMf @CpnyId, @ShipperId

	Select Cast(1 As smallint)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConfirm_SHShipHeaderInsert] TO [MSDSL]
    AS [dbo];

