 /****** Object:  Stored Procedure dbo.APDoc_RefNbr_PWP    Script Date: 06/7/06 ******/
Create Procedure APDoc_RefNbr_PWP @parm1 varchar ( 10) as
SELECT a.*
  FROM APDoc a JOIN Terms t
          ON a.Terms = t.TermsID
 WHERE RefNbr LIKE @parm1
   AND t.DiscType = 'P'
   AND a.Doctype IN ('AC','VO')
   AND a.DocBal > 0
ORDER BY RefNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_RefNbr_PWP] TO [MSDSL]
    AS [dbo];

