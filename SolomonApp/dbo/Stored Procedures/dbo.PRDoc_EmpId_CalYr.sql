 Create Proc  PRDoc_EmpId_CalYr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select * from PRDoc
           where EmpId  =  @parm1
             and CalYr  =  @parm2
           order by EmpId,
                    CalYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_EmpId_CalYr] TO [MSDSL]
    AS [dbo];

