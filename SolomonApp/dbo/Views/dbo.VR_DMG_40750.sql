 

CREATE VIEW VR_DMG_40750

 AS

--SOShipLineSplit 	s
--SOShipHeader 		h
--ARDoc			d
--ARTran		t

select 	
	s.CpnyID, s.CreditPct, s.SlsperID, s.LineRef,
	h.DiscPct, 
	d.PerClosed, d.OrigDocAmt, 
	t.CustId, t.DrCr, t.ExtCost, t.InvtId, t.ShipperLineRef, t.Qty, t.RefNbr, 
	Disc = Sum(Coalesce(ARTranDisc.TranAmt, 0)), 
	OrderDisc =   ((t.TranAmt - Sum(Coalesce(ARTranDisc.TranAmt, 0))) * (h.DiscPct /100)),
	TranAmt = (t.TranAmt - Sum(Coalesce(ARTranDisc.TranAmt, 0))),
	t.TranClass, t.TranDate, t.TranType, t.UnitDesc, t.UnitPrice, t.PerPost, t.Rlsed, s.shipperId
from
SOShipLineSplit s
		Inner join soshipline l on
			s.cpnyid = l.cpnyid and
			s.shipperid = l.shipperid and
			s.lineref = l.lineref
	     INNER JOIN SOShipHeader h ON
	        s.CpnyID = h.CpnyID AND
	    	s.ShipperID = h.ShipperID
	     INNER JOIN ARDoc d ON
	        h.CpnyID = d.CpnyID AND
	    	h.CustID = d.CustId AND
	    	h.InvcNbr = d.RefNbr AND
		d.DocClass = 'N'
	     INNER JOIN ARTran t ON
	        d.CpnyID = t.CpnyID AND
	     	d.CustId = t.CustId AND
            s.ShipperID = t.ShipperID AND
	    	d.RefNbr = t.RefNbr AND
		t.TranClass = 'N'
	    LEFT OUTER JOIN ARTran ARTranDisc ON
	        d.CpnyID = ARTranDisc.CpnyID AND
	    	d.CustId = ARTranDisc.CustId AND
            s.ShipperID = ARTranDisc.ShipperID AND
	    	s.LineRef = ARTranDisc.ShipperLineRef AND
	    	d.RefNbr = ARTranDisc.RefNbr AND
	    	ARTranDisc.TranClass = 'D'
	GROUP BY s.CpnyID, s.CreditPct, s.SlsperID, s.LineRef,
			l.DiscPct,h.DiscPct,  
			d.PerClosed, d.OrigDocAmt, 
			t.CustId, t.DrCr, t.ExtCost, t.InvtId,t.ShipperLineRef, t.Qty, t.RefNbr, 
			t.TranClass, t.TranDate, t.TranType, t.UnitDesc, t.UnitPrice, 
			t.PerPost, t.Rlsed, t.TranAmt, s.shipperid


 
