 Create Proc Delete_BOMDoc @parm1 varchar (10) as
    Delete bomdoc
			from BOMDoc
				left outer join BOMTran
					on BOMDoc.RefNbr = BOMTran.RefNbr
            where (BOMDoc.PerPost <= @parm1 and BOMDoc.PerPost IS NOT NULL)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_BOMDoc] TO [MSDSL]
    AS [dbo];

