 Create Proc  PRTran_EmpId_TSht @parm1 varchar ( 10), @parm2 smallint as
       Select * from PRTran
           where EmpId       =  @parm1
             and TimeShtFlg  =  @parm2
           order by EmpId     ,
                    TimeShtFlg



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_EmpId_TSht] TO [MSDSL]
    AS [dbo];

