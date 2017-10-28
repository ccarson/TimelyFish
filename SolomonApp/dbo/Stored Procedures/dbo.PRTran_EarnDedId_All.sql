 Create Proc PRTran_EarnDedId_All @parm1 varchar ( 10), @parm2 varchar( 10) as
         Select PRTran.* From PRTran, Employee
                Where PRTran.EmpId = Employee.EmpId
                  and EarnDedId = @parm1
                  and TranType IN ('CK','HC','VC')
                  and Type_ = 'DW'
                  and Rlsed <> 0
                  and APBatch = ''
                  and Employee.CpnyId = @parm2
         order by PRTran.CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_EarnDedId_All] TO [MSDSL]
    AS [dbo];

