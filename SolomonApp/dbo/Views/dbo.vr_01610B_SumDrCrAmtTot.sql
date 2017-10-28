 

CREATE VIEW vr_01610B_SumDrCrAmtTot AS
   SELECT    
      -- GLTran Fields
      GLTranCpnyid   = t.CpnyID,
      GLTranAcct     = t.Acct,
      GLTranSub      = t.Sub,
      GLTranLedgerID = t.Ledgerid,
      GLTranFiscYr   = t.Fiscyr,          
      GLTranPosted   = t.Posted,  
      --View Specific Fields
      GLTranDrAmtTot = SUM(Convert(dec(28,3),t.dramt)),
      GLTranCrAmtTot = SUM(Convert(dec(28,3),t.cramt)),
      Trans_Flag     = 'G',
      r.RI_ID
   FROM RptRunTime      r (NOLOCK) INNER JOIN GLTran t 
                                      ON t.PerPost >= r.BegPerNbr AND 
	                                 t.PerPost <= r.EndPerNbr
   WHERE t.Posted = 'P' 
   GROUP BY 
      r.RI_ID,
      t.CpnyID,
      t.Acct,
      t.Sub,
      t.Ledgerid,
      t.Fiscyr,
      t.Posted


 
