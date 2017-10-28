 /****** Object:  Stored Procedure dbo.AR_SBal_WO_Cpny    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc AR_SBal_WO_Cpny @parm1 varchar(10), @parm2 float AS
SELECT d.*
  FROM ARDoc d LEFT OUTER JOIN artran t
                 ON d.CustID = t.CustID AND d.DocType = t.CostType AND
                    d.RefNbr  = t.SiteID AND t.DrCr = 'U'
 WHERE d.CpnyID = @parm1 AND d.Doctype IN ('IN', 'DM', 'FI')
   AND d.DocBal <= @parm2 AND d.DocBal <> 0
   AND d.rlsed = 1
   AND t.trantype IS NULL
 ORDER BY d.CpnyID, d.Doctype, d.Refnbr


