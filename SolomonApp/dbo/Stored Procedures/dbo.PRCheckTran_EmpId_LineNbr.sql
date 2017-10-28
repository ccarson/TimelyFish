 Create Proc  PRCheckTran_EmpId_LineNbr @parm1 varchar ( 10), @parm2 int as
       Select * from PRCheckTran
           where EmpId  =  @parm1 and
		 LineNbr = @parm2
           order by EmpId,
                    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRCheckTran_EmpId_LineNbr] TO [MSDSL]
    AS [dbo];

