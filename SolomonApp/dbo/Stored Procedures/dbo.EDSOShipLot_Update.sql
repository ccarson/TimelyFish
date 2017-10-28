 CREATE Proc EDSOShipLot_Update
	@CpnyId varchar(10),
	@ShipperId varchar(15),
	@Prog varchar(8),
	@User varchar(10)
As

Declare @NbrPallets smallint
Declare @NbrBoxes smallint

Begin Transaction

Select	Max(User1) as User1,
	Max(User2) as User2,
	Max(User3) as User3,
	Max(User4) as User4,
	Max(User5) as User5,
	Max(User6) as User6,
	Max(User7) as User7,
	Max(User8) as User8,
	Max(User9) as User9,
	Max(User10) as User10,
	LineRef, WhseLoc, LotSerNbr
Into #SOShipLotUser
From SOShipLot
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId
	And LineRef In (
		Select
		Distinct LineRef
		From EDContainerDet
		Where CpnyId = @CpnyId
			And ShipperId = @ShipperId)
Group By LineRef, WhseLoc, LotSerNbr

-- Delete SOShipLot records for which containers have been created as we will be adding these back
-- based on data from the container details.
Delete
From SOShipLot
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId
	And LineRef In (Select Distinct LineRef
					From EDContainerDet
					Where CpnyId = @CpnyId
					And ShipperId = @ShipperId)

-- Set the QtyShip to zero on any remaining SOShipLot records as nothing from them was packed
Update SOShipLot
Set QtyShip = 0
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId

-- Put data from the container details into a temporary table
Select Identity(int,1,1) 'Counter', WhseLoc, LotSerNbr,  LineRef, Sum(QtyShipped) 'QtyShip', Cast(' ' as char(5)) 'LotSerRef'
Into #SOShipLotUpd
From EDContainerDet
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId
Group By LineRef, WhseLoc, LotSerNbr

-- Turn the identity column on the temp table into a string value that can be used as LotSerRef
-- when these records are inserted into SOShipLot
Update #SOShipLotUpd
Set LotSerRef = Right('00000' + Cast(Counter - (Select Count(*)
												From #SOShipLotUpd B
												Where LineRef < #SOShipLotUpd.LineRef) As varchar(5)),5)

-- QN 08/21/2001, 4.51 version - new fields: MfgrLotSetNbr, SpecificCostID, OrdLineRef, OrdLotSerRef, OrdNbr, OrdSchedRef
-- Insert rows from the temp table into SOShipLot
Insert Into SOShipLot Select ' ' 'BoxRef', A.CpnyId 'CpnyID', GetDate() 'Crtd_DateTime',
  @Prog 'Crtd_Prog', @User 'Crtd_User', A.DropShip 'DropShip', B.InvtId 'InvtId',
  C.LineRef 'LineRef', C.LotSerNbr 'LotSerNbr', C.LotSerRef 'LotSerRef',
  GetDate() 'LUpd_DateTime', @Prog 'LUpd_Prog', @User 'LUpd_User', ' ' 'MfgrLotSerNbr', 0 'NoteID',
  ' ' 'OrdLineRef', ' ' 'OrdLotSerRef', ' ' 'OrdNbr', ' ' 'OrdSchedRef',
  0 'QtyPick', 0 'QtyPickStock', C.QtyShip 'QtyShip', ' ' 'RMADisposition', ' ' 'S4Future01', ' ' 'S4Future02',
  0 'S4Future03', 0 'S4Future04', 0 'S4Future05', 0 'S4Future06', '01/01/1900' 'S4Future07',
  '01/01/1900' 'S4Future08', 0 'S4Future09', 0 'S4Future10', ' ' 'S4Future11', ' ' 'S4Future12',
  A.ShipperId 'ShipperID', ' ' 'SpecificCostID',
  IsNull(D.User1, '') 'User1', IsNull(D.User10, '01/01/1900') 'User10',
  IsNull(D.User2, '') 'User2', IsNull(D.User3, '') 'User3',
  IsNull(D.User4, '') 'User4', IsNull(D.User5, 0) 'User5',
  IsNull(D.User6, 0) 'User6',   IsNull(D.User7, '') 'User7',
  IsNull(D.User8, '') 'User8',  IsNull(D.User9, '01/01/1900') 'User9',
  C.WhseLoc 'WhseLoc', NULL 'tstamp' From SOShipHeader A Inner Join SOShipLine B On A.CpnyId =
  B.CpnyId And A.ShipperId = B.ShipperId Inner Join #SOShipLotUpd C On B.LineRef = C.LineRef Left Outer Join
  #SOShipLotUser D On D.LineRef = C.LineRef And D.WhseLoc = C.WhseLoc And D.LotSerNbr = C.LotSerNbr
  Where A.CpnyId = @CpnyId And A.ShipperId = @ShipperId

-- Update values on soshipheader
Select @NbrPallets = Count(*)
From EDContainer
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId
	And TareFlag = 1

Select @NbrBoxes = Count(*)
From EDContainer
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId
	And TareFlag = 0

Update SOShipHeader
Set TotPallets = @NbrPallets, TotBoxes = @NbrBoxes
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId

-- Fill in QTYPick on SOShipLot where lineref = '0001'
Update SOShipLot
Set QtyPick = B.QtyPick
From SOShipLot A
	Inner Join SOShipLine B
		On A.CpnyId = B.CpnyId
			And A.ShipperId = B.ShipperId
			And A.LineRef = B.LineRef
Where A.CpnyId = @CpnyId
	And A.ShipperId = @ShipperId
	And A.LotSerRef = '00001'

-- Update QtyShip on SOShipLine
Update SOShipLine
Set QtyShip = (Select Sum(QtyShip)
				From SOShipLot
				Where SOShipLot.CpnyId = SOShipLine.CpnyId
					And SOShipLot.ShipperId = SOShipLine.ShipperId
					And SOShipLot.LineRef = SOShipLine.LineRef),
LotSerCntr = (Select Count(*)
				From SOShipLot
				Where SOShipLot.CpnyId = SOShipLine.CpnyId
					And SOShipLot.ShipperId = SOShipLine.ShipperId
					And SOShipLot.LineRef = SOShipLine.LineRef)
Where CpnyId = @CpnyId
	And ShipperId = @ShipperId

Commit Transaction



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_Update] TO [MSDSL]
    AS [dbo];

