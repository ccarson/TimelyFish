 /****** Object:  Stored Procedure dbo.ARDoc_RefNbr_PWP    Script Date: 06/7/06 ******/
Create Procedure ARDoc_RefNbr_PWP @parm1 varchar ( 10) as
SELECT *
  FROM ARDoc
 WHERE RefNbr LIKE @parm1
   AND DocType = 'IN' AND DocBal <> 0
 ORDER BY RefNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_RefNbr_PWP] TO [MSDSL]
    AS [dbo];

