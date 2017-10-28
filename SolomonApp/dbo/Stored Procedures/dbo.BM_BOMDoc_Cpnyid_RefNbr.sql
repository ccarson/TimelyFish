 Create Proc BM_BOMDoc_Cpnyid_RefNbr @parm1 varchar ( 10), @parm2 varchar (15) as
    Select * from BOMDoc where
	Cpnyid = @parm1 and
	RefNbr = @parm2
	order by Cpnyid, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BM_BOMDoc_Cpnyid_RefNbr] TO [MSDSL]
    AS [dbo];

