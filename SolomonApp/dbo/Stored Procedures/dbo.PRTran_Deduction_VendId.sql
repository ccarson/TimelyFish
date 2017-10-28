 Create Proc PRTran_Deduction_VendId @parm1 varchar( 10), @parm2 varchar (10) as
         Select PRTran.*, Deduction.* From PRTran, Deduction, Employee
                Where PRTran.Batnbr = @parm1
                  and PRTran.TranType IN ('CK','HC','VC')
                  and PRTran.Type_ = 'DW'
                  and PRTran.Rlsed <> 0
                  and PRTran.APBatch = ''
                  and PRTran.EarnDedId = Deduction.DedId
                  and PRTran.CalYr     = Deduction.CalYr
                  and Deduction.VendId <> ''
                  and PRTran.EmpId = Employee.EmpId
                  and Employee.CpnyId = @parm2
                Order By Deduction.VendId,
                         Deduction.DedId,
                         PRTran.CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_Deduction_VendId] TO [MSDSL]
    AS [dbo];

