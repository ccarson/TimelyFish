 Create Proc AR_SCred_WO_Cust @parm1 varchar(15), @parm2 float, @parm3 varchar(47), @parm4 varchar(7), @parm5 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
SELECT d.*
  FROM ARDoc d LEFT OUTER JOIN artran t
                 ON d.custid = t.custid AND
                    d.DocType = t.TranType AND
                    d.RefNbr = t.RefNbr AND
                    t.drcr = 'U'
 WHERE d.CustID = @parm1
   AND d.Doctype IN ('PA', 'CM', 'PP')
   AND d.DocBal <= @parm2
   AND d.DocBal <> 0
   AND d.rlsed = 1
   AND d.cpnyid IN

       (SELECT Cpnyid
          FROM vs_share_usercpny
         WHERE userid = @parm3
           AND scrn = @parm4
           AND seclevel >= @parm5)
   AND t.TranType IS NULL

 ORDER BY d.CustID, d.Doctype, d.Refnbr


