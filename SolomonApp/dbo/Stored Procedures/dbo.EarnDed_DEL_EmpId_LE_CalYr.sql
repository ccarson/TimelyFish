 Create Proc  EarnDed_DEL_EmpId_LE_CalYr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Delete earnded from EarnDed
           where EmpId   =  @parm1
             and CalYr  <=  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_DEL_EmpId_LE_CalYr] TO [MSDSL]
    AS [dbo];

