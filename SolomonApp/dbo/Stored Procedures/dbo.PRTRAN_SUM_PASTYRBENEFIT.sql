 Create Proc  PRTRAN_SUM_PASTYRBENEFIT @parm1 varchar ( 10), @parm2 smallint,  @parm3 varchar ( 10), @parm4 smalldatetime, @parm5 smalldatetime as
       Select  SUM( Qty)  from PRTran
           where EmpId       =  @parm1
             and Rlsed       =  @parm2
			 and EarnDedId   IN(select id from earntype where benclassid =  @parm3)
			 and TranDate    <  @parm4
			 and TranDate    >=  @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTRAN_SUM_PASTYRBENEFIT] TO [MSDSL]
    AS [dbo];

