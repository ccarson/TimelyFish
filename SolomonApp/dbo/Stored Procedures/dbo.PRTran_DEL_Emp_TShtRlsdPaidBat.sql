 Create Proc  PRTran_DEL_Emp_TShtRlsdPaidBat @parm1 varchar ( 10), @parm2 smallint, @parm3 smallint, @parm4 smallint, @parm5 varchar ( 10) as
       Delete prtran from PRTran
           where EmpId       =  @parm1
             and TimeShtFlg  =  @parm2
             and Rlsed       =  @parm3
             and Paid        =  @parm4
             and BatNbr      =  @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_DEL_Emp_TShtRlsdPaidBat] TO [MSDSL]
    AS [dbo];

