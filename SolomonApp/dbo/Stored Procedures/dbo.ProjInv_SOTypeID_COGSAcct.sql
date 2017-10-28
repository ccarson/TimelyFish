
Create Proc ProjInv_SOTypeID_COGSAcct @parm1 VarChar (30), @parm2 VarChar (10) as
     SELECT s.SOTypeID, s.OrdNbr, s.Custid, t.COGSAcct, t.COGSSub, s.ShipCustID, s.ShiptoID, s.ShipViaID 
       FROM SOHeader s JOIN SOType t
         ON s.SOTypeID = t.SOTypeID
        AND s.CpnyID = t.CpnyID
      WHERE s.OrdNbr = @parm1 
        AND s.CpnyID = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_SOTypeID_COGSAcct] TO [MSDSL]
    AS [dbo];

