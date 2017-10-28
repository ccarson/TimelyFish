 Create proc p08990UpdCurBal @ARPerRetTran Varchar(6), @OMPerRetTran VarChar(6) as

Update a set

a.currbal = Round(v.NewCurrentBal, c.decpl),
a.futurebal = Round(v.NewFutureBal, c.decpl)

From AR_Balances a, vi_08990CompCustBal v, currncy c (nolock), glsetup g (nolock)

Where a.custid = v.custid and
      a.cpnyid = v.cpnyid and
      (Round(a.currbal, c.decpl) <> Round(v.NewCurrentBal, c.decpl) or
       Round(a.futurebal, c.decpl) <> Round(v.NewFutureBal, c.decpl))
and g.basecuryid = c.curyid

UPDATE a
  SET TotShipped = ROUND(s.BalDue, c.decpl)

  FROM  AR_Balances a
  	INNER JOIN (
  		select sum(Case When d.Custid IS NULL THEN s1.BalDue ELSE 0 End) as BalDue, s1.CpnyID, s1.CustID from SoShipHeader s1
  			LEFT OUTER JOIN ARDoc d ON d.BatNbr = s1.ARBatNbr AND d.RefNbr = s1.InvcNbr AND d.Rlsed = 1 AND d.CustID = s1.CustID AND d.CpnyID = s1.CpnyID
  			where s1.Status = 'C' and Cancelled = 0
  			group by s1.CpnyID, s1.CustID) s
  		ON s.CpnyID = a.CpnyID AND s.CustID = a.CustID
  	CROSS JOIN GLSetup g
  	INNER JOIN Currncy c ON g.BaseCuryID = c.CuryID

If @ARPerRetTran > @OMPerRetTran
BEGIN
     UPDATE a
        SET TotShipped = TotShipped - ROUND(s.BalDue, c.decpl)
       FROM  AR_Balances a
             INNER JOIN (SELECT sum(s1.BalDue) as BalDue, s1.CpnyID, s1.CustID
                           FROM SoShipHeader s1 LEFT OUTER JOIN ARDoc d
                                                  ON d.BatNbr = s1.ARBatNbr AND d.RefNbr = s1.InvcNbr
                                                 AND d.Rlsed = 1 AND d.CustID = s1.CustID AND d.CpnyID = s1.CpnyID
  			  WHERE s1.Status = 'C' AND Cancelled = 0 AND d.CustID IS NULL
                            AND s1.PerPost < @ARPerRetTran AND s1.ShipRegisterID <> ' '
  			  GROUP BY s1.CpnyID, s1.CustID) s
  		ON s.CpnyID = a.CpnyID AND s.CustID = a.CustID
  	     CROSS JOIN GLSetup g
  	     INNER JOIN Currncy c
                ON g.BaseCuryID = c.CuryID
END

UPDATE a
  SET TotShipped = TotShipped - ROUND(accrued, c.decpl),
      AccruedRevBal = ROUND(accrued, c.decpl)
  FROM  AR_Balances a
  	INNER JOIN (
  		select sum(CASE d.DocType WHEN 'AD' THEN CONVERT(dec(28,3),d.OrigDocAmt) WHEN 'RA' THEN -CONVERT(dec(28,3),d.OrigDocAmt) ELSE 0 END) as Accrued, s1.CpnyID, s1.CustID
                from SoShipHeader s1
  		JOIN ARDoc d on d.RefNbr = s1.ShipperID and d.Rlsed = 1 AND d.CustID = s1.CustID AND d.CpnyID = s1.CpnyID AND d.DocType in ('AD','RA')
  		where s1.Status = 'C' and Cancelled = 0
  		group by s1.CpnyID, s1.CustID) s
  		ON s.CpnyID = a.CpnyID AND s.CustID = a.CustID
  	CROSS JOIN GLSetup g
  	INNER JOIN Currncy c ON g.BaseCuryID = c.CuryID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990UpdCurBal] TO [MSDSL]
    AS [dbo];

