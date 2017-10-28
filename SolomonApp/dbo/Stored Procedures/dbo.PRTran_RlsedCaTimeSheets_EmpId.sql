 Create Proc PRTran_RlsedCaTimeSheets_EmpId @parm1 varchar ( 10) as
       Select * from PRTran
           where EmpId       =  @parm1
             and TranType    =  'CA'
             and Rlsed       =  1
             and Paid        =  0
             and (TimeShtFlg  =  1 or Type_ = 'NC')
           order by EmpId,
                    TimeShtFlg,
                    Rlsed     ,
                    Paid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_RlsedCaTimeSheets_EmpId] TO [MSDSL]
    AS [dbo];

