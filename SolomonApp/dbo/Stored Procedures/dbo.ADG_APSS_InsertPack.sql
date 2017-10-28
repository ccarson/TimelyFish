 CREATE PROCEDURE ADG_APSS_InsertPack
	@CpnyID       VARCHAR(10),
        @ShipperID    VARCHAR(15),
	@BoxID        INTEGER,
	@BaseCost     FLOAT,  -- Base cost for the specified service type
	@CODAmt       FLOAT,  -- Amount of COD
	@CODCost      FLOAT,  -- COD surcharge
	@HandlingChg  FLOAT,
	@InsureCost   FLOAT,
	@AllCost      FLOAT,  -- Base cost plus services
	@OversizeCost FLOAT,
	@PackageID    VARCHAR(15),
	@TrackingNbr  VARCHAR(20),
	@Wght         FLOAT
AS
	INSERT SHShipPack (
		BaseCost,
		BoxRef,
		CODAmt,
		CODCost,
		CpnyID,
		Crtd_DateTime,
		Crtd_Prog,
		Crtd_User,
		CuryID,
		HandlingChg,
		InsureCost,
		LUpd_DateTime,
		LUpd_Prog,
		LUpd_User,
		OtherCost,

		OversizeCost,
		PackageID,
		PalletID,
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
		ShipperID,
		TrackingNbr,
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
		Volume,
		Wght
	)
	VALUES (
		@BaseCost, --BaseCost
			   -- Make sure the 5 in this expression is the width of the BoxRef column in the SHShipPack table.
		REPLICATE( '0', 5 - DATALENGTH(CONVERT(VARCHAR,@BoxID))) + CONVERT(VARCHAR,@BoxID),
		@CODAmt,       --CODAmt
		@CODCost,      --CODCost
		@CpnyID,       --CpnyID
		getdate(),
		'',
		'',
		'',            --CuryID
		@HandlingChg,  --HandlingChg
		@InsureCost,   --InsureCost
		getdate(),
		'',
		'',
		@AllCost - @BaseCost,    --OtherCost
		@OversizeCost, --OversizeCost
		@PackageID,    --PackageID,
		'',            --PalletID
		'',            --S4Future01
		'',            --S4Future02
		0,             --S4Future03
		0,             --S4Future04
		0,             --S4Future05
		0,             --S4Future06
		GETDATE(),     --S4Future07
		GETDATE(),     --S4Future08
		0,             --S4Future09
		0,             --S4Future10
		'',            --S4Future11
		'',            --S4Future12
		@ShipperID,    --ShipperID
		@TrackingNbr,  --TrackingNbr
		'',            --User1
		GETDATE(),     --User10
		'',            --User2
		'',            --User3
		'',            --User4
		0,             --User5
		0,             --User6
		'',            --User7
		'',            --User8
		GETDATE(),     --User9
		0,             --Volume
		@Wght          --Wght

)-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


