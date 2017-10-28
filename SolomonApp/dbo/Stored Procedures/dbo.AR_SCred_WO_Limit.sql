 Create Proc AR_SCred_WO_Limit @parm1 float, @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
SELECT d.*
  FROM ardoc d LEFT OUTER JOIN artran t
                 ON d.custid = t.custid AND
                    d.DocType = t.TranType AND
                    d.RefNbr = t.RefNbr AND
                    t.drcr = 'U'
 WHERE d.Doctype IN ('PA', 'CM', 'PP')
   AND d.DocBal <= @parm1
   AND d.DocBal <> 0
   AND d.rlsed = 1
   AND d.cpnyid in

       (SELECT Cpnyid
          FROM vs_share_usercpny
         WHERE userid = @parm2
           AND scrn = @parm3
           AND seclevel >= @parm4)
   AND t.trantype IS NULL

 ORDER BY d.CpnyID, d.Doctype, d.Refnbr


