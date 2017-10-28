 /****** Object:  Stored Procedure dbo.AR_SCred_WO_Cpny    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc AR_SCred_WO_Cpny @parm1 varchar(10), @parm2 float AS
SELECT d.*
  FROM ARDoc d LEFT OUTER JOIN artran t
                 ON d.custid = t.custid AND
                    d.DocType = t.TranType AND
                    d.RefNbr = t.RefNbr AND
                    t.drcr = 'U'
 WHERE d.CpnyID = @parm1
   AND d.Doctype IN ('PA', 'CM', 'PP')
   AND d.DocBal <= @parm2 AND d.DocBal <> 0
   AND d.rlsed = 1 AND t.trantype IS NULL
 ORDER BY d.CpnyID, d.Doctype, d.Refnbr


