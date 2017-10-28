 CREATE PROCEDURE ARDocBatNbrCustID  @parm1 AS varchar (10) , @parm2 as varchar (15), @parm3 as varchar (15) as
SELECT * FROM ARDoc WHERE
BatNbr LIKE @parm1 AND
CustID LIKE @parm2 AND
RefNbr LIKE @parm3 AND
DocType <> 'RC'
ORDER BY BatNBr, CustID, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDocBatNbrCustID] TO [MSDSL]
    AS [dbo];

