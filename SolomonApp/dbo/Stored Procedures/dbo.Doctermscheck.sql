 Create proc Doctermscheck @parm1 varchar(6) As

SELECT d.batnbr,d.refnbr,d.doctype,Min(d.terms) terms
      FROM ardoc d INNER JOIN terms t
                         ON d.terms = t.termsid
                   Left Outer JOIN docterms c
                         ON d.doctype = c.doctype
                        AND d.refnbr = c.refnbr
    WHERE d.batnbr = @parm1
          AND t.termstype = 'M'
          AND c.doctype IS NULL
GROUP BY d.batnbr, d.custid, d.doctype, d.refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Doctermscheck] TO [MSDSL]
    AS [dbo];

