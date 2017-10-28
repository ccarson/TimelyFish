
CREATE Proc Create_INPrjAllocation_OU 
     @SolUser VarChar(47),
     @OrdNbr Varchar(15),
     @LineRef Varchar(5),
     @CpnyID VarChar(10),
     @QtyAlloc Float 
As

DELETE 
  FROM INPrjAllocation 
 WHERE SrcNbr = @OrdNbr
   AND SrcLineRef = @LineRef
   AND SrcType = 'SO'

INSERT InPrjAllocation (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID,
        LUpd_DateTime, LUpd_Prog, LUpd_User, OrdNbr, Priority, ProjectId, QtyAllocated,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
        S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, SiteID,SrcLineRef, SrcNbr,
        SrcType, TaskId, UnitDesc,
        User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  l.CpnyID, GETDATE(),'10400', @SolUser, l.InvtId, 
        GETDATE(), '10400', @SolUser, l.Ordnbr, h.Priority, l.ProjectID, @QtyAlloc,
        '', '', 0, 0, 0, 0,'', 
        '', 0, 0, '', '', l.SiteID, l.Lineref, l.OrdNbr,
        'SO', l.TaskID, l.UnitDesc, 
        '','',0,0,'','','','',''
FROM SOLine l JOIN SOHeader h
                ON l.OrdNbr = h.OrdNbr
               AND l.CpnyID = h.CpnyID
WHERE l.OrdNbr = @OrdNbr
  AND l.LineRef = @LineRef
  AND l.CpnyID = @CpnyID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Create_INPrjAllocation_OU] TO [MSDSL]
    AS [dbo];

