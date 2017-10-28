CREATE Proc Insert_INProjAllocation
    @ShipperID varchar(15),
    @ShipLineRef varchar(5),
    @CpnyID varchar(10),
    @WhseLoc Varchar(10),
    @OrdNbr varchar (15),
    @OrdLineRef varchar(5),
    @ProjInvConsumed float,
    @Priority int,
    @UserID varchar(10)

AS

DELETE i
  FROM INPrjAllocation i
 WHERE i.SrcNbr = @ShipperID
   AND i.SrcLineRef = @ShipLineRef
   AND i.SrcType = 'SH'
   AND i.WhseLoc = @WhseLoc 

INSERT INPrjAllocation (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID, 
LUpd_DateTime, LUpd_Prog, LUpd_User, OrdNbr, Priority, 
ProjectID, QtyAllocated, S4Future01, S4Future02, S4Future03, 
S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, 
S4Future09, S4Future10, S4Future11, S4Future12, SiteID, 
SrcLineRef, SrcNbr, SrcType, TaskID, UnitDesc, 
User1, User2, User3, User4, User5, 
User6, User7, User8, WhseLoc)
SELECT s.CpnyID, GetDate(), '40400', @UserID, s.InvtID, 
GetDate(), '40400', @UserID, @OrdNbr, @Priority, 
s.ProjectID, @ProjInvConsumed, '', '', 0, 
0, 0, 0, '', '', 
0, 0, '', '', s.SiteID, 
s.LineRef, s.ShipperID, 'SH', s.TaskID, v.StkUnit, 
'','',0,0,'',
'','','', @WhseLoc
  FROM  SOShipLine s JOIN Inventory v WITH(NOLOCK)
                       ON s.InvtID = v.InvtID
 WHERE s.ShipperID = @ShipperID
   AND s.LineRef = @ShipLineRef
   AND s.CpnyID = @CpnyID

DELETE i 
  FROM INPrjAllocation i 
 WHERE i.SrcNbr = @OrdNbr
   AND i.SrcLineRef = @OrdLineRef
   AND i.SrcType = 'SO'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Insert_INProjAllocation] TO [MSDSL]
    AS [dbo];

