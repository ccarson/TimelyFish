 /****** Object:  Stored Procedure dbo.ARDoc_Cpny_CustId_Cls_byclass    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_Cpny_CustId_Cls_byclass @parm1 varchar ( 15), @parm2 varchar ( 10) as
    SELECT DISTINCT d.*
      FROM ardoc d LEFT OUTER JOIN ARTran t
                     ON d.Custid = t.Custid
                    AND d.Refnbr = t.SiteID
                    AND d.Doctype = t.CostType
     WHERE d.custid like @parm1
       AND d.doctype IN ('FI', 'IN', 'DM', 'NC')
       AND d.curydocbal > 0
       AND d.Rlsed = 1
       AND d.CpnyID Like @parm2
       AND t.Custid IS NULL
       AND ISNULL(t.DRCR,'U') = 'U'
    order by d.CustId, d.DocClass, d.DocDate, d.Refnbr




GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Cpny_CustId_Cls_byclass] TO [MSDSL]
    AS [dbo];

