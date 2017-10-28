 Create Proc  PRTran_EmpIdTShtRlsedPaidTType @parm1 varchar ( 10), @parm2 smallint, @parm3 smallint, @parm4 smallint, @parm5 varchar ( 2) as
       Select * from PRTran
           where EmpId       =  @parm1
             and TimeShtFlg  =  @parm2
             and Rlsed       =  @parm3
             and Paid        =  @parm4
             and TranType    =  @parm5
           order by EmpId,
                    TimeShtFlg,
                    Rlsed     ,
                    Paid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_EmpIdTShtRlsedPaidTType] TO [MSDSL]
    AS [dbo];

