 Create Proc BOMDoc_Cpnyid_RefNbr_Status @parm1 varchar ( 10), @parm2 varchar (15) as
    Select * from BOMDoc where Status <> 'V' and
	Cpnyid = @parm1 and
	RefNbr like @parm2
	order by Cpnyid, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMDoc_Cpnyid_RefNbr_Status] TO [MSDSL]
    AS [dbo];

