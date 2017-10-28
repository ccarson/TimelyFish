 Create procedure ARTran_Update_Taxes @parm1 varchar (15), @parm2 varchar (2), @parm3 varchar(10)
AS
SELECT *  FROM artran
 WHERE custid  = @parm1 and trantype = @parm2 and refnbr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_Update_Taxes] TO [MSDSL]
    AS [dbo];

