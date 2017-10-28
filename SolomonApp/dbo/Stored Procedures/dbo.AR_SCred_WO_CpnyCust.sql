 /****** Object:  Stored Procedure dbo.AR_SCred_WO_CpnyCust    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc AR_SCred_WO_CpnyCust @parm1 varchar(15), @parm2 varchar(10), @parm3 float AS
SELECT d.*
  FROM ARDoc d LEFT OUTER JOIN artran t
                 ON d.custid = t.custid AND
                    d.DocType = t.TranType AND
                    d.RefNbr = t.RefNbr AND
                    t.drcr = 'U'
 WHERE d.CustID = @parm1
   AND d.CpnyID = @parm2
   AND d.Doctype IN ('PA', 'CM', 'PP')
   AND d.DocBal <= @parm3
   AND d.DocBal <> 0
   AND d.rlsed = 1
   AND t.trantype IS NULL
 ORDER BY d.CustID, d.Doctype, d.Refnbr


