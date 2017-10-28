 

CREATE VIEW dbo.ED850Head2Line
AS
SELECT a.CpnyID, a.EDIPOID, a.OrdNbr, b.InvtID, b.LineRef, 
    b.DiscPct, b.QtyOrd, b.SlsPrice, b.Descr, b.QtyShip, b.TotCost, 
    b.TotOrd
FROM SOHeader a, SOLine b
WHERE a.CpnyID = b.CpnyID AND a.OrdNbr = b.OrdNbr AND 
    a.Cancelled = 0

 
