 Create Proc  PRCheckTran_DEL_EmpId_ChkSeq @parm1 varchar ( 10), @parm2 varchar(2) as
    Delete prchecktran from PRCheckTran
                 where EmpId  =  @parm1
                   and ChkSeq =  @parm2
		   and ASID = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRCheckTran_DEL_EmpId_ChkSeq] TO [MSDSL]
    AS [dbo];

