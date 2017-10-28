
CREATE Proc Create_INPrjAllocation @parm1 varchar(15), @parm2 varchar (3)
As
SET NOCOUNT ON

INSERT InPrjAllocation (CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, InvtID,
        LUpd_DateTime, LUpd_Prog, LUpd_User, OrdNbr, Priority, ProjectId, QtyAllocated,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
        S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, SiteID,SrcLineRef, SrcNbr,
        SrcType, TaskId, UnitDesc,
        User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  Max(L.CpnyID), GETDATE(),Max(L.Crtd_Prog), Max(L.Crtd_User), L.InvtId, 
        GETDATE(), Max(L.LUpd_Prog), Max(L.LUpd_User), Max(L.OrdNbr), Max(L.Priority), Max(L.ProjectID), sum(L.QtyAllocated),
        '', '', 0, 0, 0, 0,'', 
        '', 0, 0, '', '', Max(L.SiteID), L.SrcLineref, L.SrcNbr,
        L.SrcType, Max(L.TaskID), Max(L.UnitDesc), 
        '','',0,0,'','','','',L.WhseLoc
FROM inprjallocationLot L
WHERE L.SrcNbr = @Parm1
      AND  L.SrcType = @Parm2
GROUP BY L.SrcNbr,L.SrcLineRef,L.SrcType,L.InvtId, L.SiteId,L.WhseLoc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Create_INPrjAllocation] TO [MSDSL]
    AS [dbo];

