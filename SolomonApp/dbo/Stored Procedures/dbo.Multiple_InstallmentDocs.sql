 Create procedure Multiple_InstallmentDocs @parm1 varchar ( 6) as
       Select d.Batnbr, d.custid, d.Doctype, d.Refnbr, d.Terms
         From ARDoc d, terms t
           Where d.Batnbr = @parm1
             and d.Terms = t.termsid
             and t.termstype = 'M'

 order by  BatNbr, custid, Doctype, refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Multiple_InstallmentDocs] TO [MSDSL]
    AS [dbo];

