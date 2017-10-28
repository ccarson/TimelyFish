CREATE Proc Insert_INProjAllocationLot
    @ShipperID varchar(15),
    @ShipLineRef varchar(5),
    @CpnyID varchar(10),
    @WhseLoc Varchar(10),
    @OrdNbr varchar (15),
    @OrdLineRef varchar(5),
    @ProjInvConsumed float,
    @Priority int,
    @UserID varchar(10),
    @LotSerNbr varchar(25),
    @LotSerRef varchar(5)

AS

DELETE i
  FROM INPrjAllocationLot i
 WHERE i.SrcNbr = @ShipperID
   AND i.SrcLineRef = @ShipLineRef
   AND i.SrcType = 'SH'
   AND i.LotSerNbr = @LotSerNbr
   AND i.LotSerRef = @LotSerRef

INSERT INPrjAllocationLot (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID, 
LotSerNbr, LotSerRef, LUpd_DateTime, LUpd_Prog, LUpd_User, 
OrdNbr, Priority, ProjectID, QtyAllocated, S4Future01, 
S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, 
S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, 
S4Future12, SiteID, SrcLineRef, SrcNbr, SrcType, 
TaskID, UnitDesc, User1, User2, User3, 
User4, User5, User6, User7, User8, WhseLoc)
SELECT s.CpnyID, GetDate(), '40400', @UserID, l.InvtID, 
@LotSerNbr, @LotSerRef, GetDate(), '40400', @UserID, 
@OrdNbr, @Priority, l.ProjectID, @ProjInvConsumed, '', 
'', 0, 0, 0, 0, 
'', '', 0, 0, '', 
'', l.SiteID, s.LineRef, s.ShipperID, 'SH', 
l.TaskID, v.StkUnit, '','',0,
0,'','','','', @WhseLoc
  FROM  SOShipLot s JOIN Inventory v WITH(NOLOCK)
                      ON s.InvtID = v.InvtID
                    JOIN SOShipLine l
                      ON l.CpnyID = s.CpnyID
                     AND l.ShipperID = s.ShipperID
                     AND l.LineRef = s.LineRef
 WHERE s.CpnyID = @CpnyID
   AND s.ShipperID = @ShipperID
   AND s.LineRef = @ShipLineRef
   AND s.LotSerRef = @LotSerRef

DELETE i 
  FROM INPrjAllocationLot i 
 WHERE i.SrcNbr = @OrdNbr
   AND i.SrcLineRef = @OrdLineRef
   AND i.SrcType = 'SO'
   AND i.LotSerNbr = @LotSerNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Insert_INProjAllocationLot] TO [MSDSL]
    AS [dbo];

