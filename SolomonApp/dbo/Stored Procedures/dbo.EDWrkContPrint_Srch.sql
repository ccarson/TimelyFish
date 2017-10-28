 Create Procedure EDWrkContPrint_Srch
	@AccessNbr SmallInt,
	@CustID VarChar(15) = '',
	@ShiptoID VarChar(10) = '',
	@CustOrdNbr VarChar(25) = '',
	@OrdNbr VarChar(15) = '',
	@ShipDateBegin SmallDateTime = '01/01/1900',
	@ShipDateEnd SmallDateTime = '01/01/1900',
	@ShipViaID VarChar(15) = '',
	@CpnyID VarChar(10) = '',
	@SiteID VarChar(10) = ''
As
Set NoCount On
-- Fix null / empty issues, if they are null or empty, switch to wildcards
Select
	@CustID = IsNull(NullIf(@CustID,''),'%'),
	@ShiptoID = IsNull(NullIf(@ShiptoID,''),'%'),
	@CustOrdNbr = IsNull(NullIf(@CustOrdNbr,''),'%'),
	@OrdNbr = IsNull(NullIf(@OrdNbr,''),'%'),
	@ShipViaID = IsNull(NullIf(@ShipViaID,''),'%'),
	@CpnyID = IsNull(NullIf(@CpnyID,''),'%'),
	@SiteID = IsNull(NullIf(@SiteID,''),'%'),
	@ShipDateBegin = IsNull(NullIf(@ShipDateBegin,'01/01/1900'),'01/01/1900'),
	@ShipDateEnd = IsNull(NullIf(@ShipDateEnd,'01/01/1900'),'01/01/2079')
-- Remove prior entries
Delete
From
	EDWrkContPrint
Where
	AccessNbr = @AccessNbr
-- Add new Items
Insert Into EDWrkContPrint
(	AccessNbr,
	CpnyID,
	CustID,
	CustOrdNbr,
	OrdNbr,
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
	Selected,
	ShipDateAct,
	ShipperID,
	ShiptoID,
	ShipViaID,
	SiteID,
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
	tstamp
)-- Now find the records
Select
	@AccessNbr As AccessNbr,
	SOShipHeader.CpnyID,
	SOShipHeader.CustID,
	SOShipHeader.CustOrdNbr,
	SOShipHeader.OrdNbr,
	'' As 'S4Future01',
	'' As 'S4Future02',
	0 As 'S4Future03',
	0 As 'S4Future04',
	0 As 'S4Future05',
	0 As 'S4Future06',
	'01/01/1900' As 'S4Future07',
	'01/01/1900' As 'S4Future08',
	0 As 'S4Future09',
	0 As 'S4Future10',
	'' As 'S4Future11',
	'' As 'S4Future12',
	0 As 'Selected',
	SOShipHeader.ShipDateAct,
	SOShipHeader.ShipperID,
	SOShipHeader.ShiptoID,
	SOShipHeader.ShipViaID,
	SOShipHeader.SiteID,
	'' As 'User1',
	'01/01/1900' As 'User10',
	'' As 'User2',
	'' As 'User3',
	'' As 'User4',
	0 As 'User5',
	0 As 'User6',
	'' As 'User7',
	'' As 'User8',
	'01/01/1900' As 'User9',
	Null As 'tstamp'
From
	SOShipHeader
Where
	SOShipHeader.CustID Like @CustID
	And SOShipHeader.ShiptoID Like @ShiptoID
	And SOShipHeader.CustOrdNbr Like @CustOrdNbr
	And SOShipHeader.OrdNbr Like @OrdNbr
	And SOShipHeader.ShipViaID Like @ShipViaID
	And SOShipHeader.ShipDateAct Between @ShipDateBegin And @ShipDateEnd
	And SOShipHeader.SiteID Like @SiteID
	And SOShipHeader.CpnyID Like @CpnyID
	-- We don't want cancelled
	And SOShipHeader.Cancelled = 0
	-- Or Closed
	And SOShipHeader.Status <> 'C'

Set NoCount Off


