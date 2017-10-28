 /****** Object:  Stored Procedure dbo.ARDoc_Cpny_CustId_Cls_bydate_Denom    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_Cpny_CustId_Cls_bydate_Denom @parm1 varchar ( 15), @parm2 varchar ( 10),
                 @parm3 varchar ( 10), @parm4 varchar ( 2) as
    SELECT DISTINCT d.*
      FROM ardoc d LEFT OUTER JOIN ARTran t
                     ON d.Custid = t.Custid
                    AND d.Refnbr = t.SiteID
                    AND d.Doctype = t.CostType
                   INNER JOIN ARDoc Pay
                     ON d.Custid = Pay.Custid
                   INNER JOIN Account a
                      ON d.BankAcct = a.Acct
     WHERE d.custid = @parm1
       AND d.Rlsed = 1
       AND d.doctype IN ('FI','IN','DM', 'NC')
       AND d.curydocbal > 0
       AND d.cpnyid Like @parm2
       AND t.Custid IS NULL
       AND ISNULL(t.DRCR,'U') = 'U'
       AND Pay.Refnbr = @parm3
       AND Pay.Doctype = @parm4
       AND (a.curyid = ' ' OR a.curyid = Pay.curyid)
    order by d.CustId, d.Rlsed, d.DueDate, d.Refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Cpny_CustId_Cls_bydate_Denom] TO [MSDSL]
    AS [dbo];

