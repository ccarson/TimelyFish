
Create Proc ProjInv_SOTypeID_COGSAcct_Line @parm1 VarChar (30), @parm2 VarChar (10), @parm3 VarChar(5) as
     SELECT s.SOTypeID, s.OrdNbr, s.Custid, t.COGSAcct, t.COGSSub, s.ShipCustID, s.ShiptoID, s.ShipViaID,
            l.CpnyID, l.ItemGlClassID, l.InvtID, l.LineRef, l.ProjectID, l.SiteID, l.TaskID 
       FROM SOLine l JOIN SOHeader s 
                       ON l.OrdNbr = s.OrdNbr
                      AND l.CpnyID = s.CpnyID
                     JOIN SOType t
         ON s.SOTypeID = t.SOTypeID
        AND s.CpnyID = t.CpnyID
      WHERE l.OrdNbr = @parm1 
        AND l.CpnyID = @parm2
        AND l.LineRef = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_SOTypeID_COGSAcct_Line] TO [MSDSL]
    AS [dbo];

