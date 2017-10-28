 CREATE PROCEDURE ADG_APSS_InsertShipment
	@CpnyID         VARCHAR(10),
	@ShipperID      VARCHAR(15),
	@PaymentMethod  INT,
	@Zone           CHAR(3),
	@ConfirmedYesNo CHAR(1)
AS

    DECLARE @Confirmed INT

	SELECT @Confirmed = CASE WHEN ( UPPER(@ConfirmedYesNo) = 'N' ) THEN 0 ELSE 1 END

	INSERT SHShipHeader (
		CpnyID,
		Crtd_DateTime,
		Crtd_Prog,
		Crtd_User,
		LUpd_DateTime,
		LUpd_Prog,
		LUpd_User,
		ShipDateAct,
		ShipperID,
		ShippingConfirmed,
		ShippingManifested,
		User1,
		User10,
		User2,
		User3,
		User4,
		User5,
		User6,
		User7,
		User8,
		User9,
		S4Future01,
		S4Future02,
		S4Future03,
		S4Future04,
		S4Future05,
		S4Future06,
		S4Future07,
		S4Future08,
		S4Future09,
		S4Future10,
		S4Future11,
		S4Future12,
		Zone
	)
	VALUES (
		@CpnyID,         -- CpnyID
		GETDATE(),       -- Crtd_DateTime
		'',              -- Crtd_Prog
		'',              -- Crtd_User
		GETDATE(),       -- LUpd_DateTime
		'',              -- LUpd_Prog
		'',              -- LUpd_User
		GETDATE(),       -- ShipDateAct
		@ShipperID,      -- ShipperID
		@Confirmed,      -- ShippingConfirmed
		1,               -- ShippingManifested
		'',              -- User1
		GETDATE(),       -- User10
		'',              -- User2
		'',              -- User3
		'',              -- User4
		0,               -- User5
		0,               -- User6
		'',              -- User7
		'',              -- User8
		GETDATE(),       -- User9
		'',		 -- S4Future01
		'',		 -- S4Future02
		0,		 -- S4Future03
		0,		 -- S4Future04
		0,		 -- S4Future05
		0,		 -- S4Future06
		'',  		 -- S4Future07
		'',		 -- S4Future08
		0,		 -- S4Future09
		0,		 -- S4Future10
		'',		 -- S4Future11
		'',		 -- S4Future12
		@Zone		 -- Zone
	)

	-- Update the process manager's queue.
	EXEC ADG_ProcessMgr_QueueUpdMf @CpnyID, @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


