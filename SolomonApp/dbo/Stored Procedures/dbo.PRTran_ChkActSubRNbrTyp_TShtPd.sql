 Create Proc  PRTran_ChkActSubRNbrTyp_TShtPd @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10), @parm4 varchar ( 2), @parm5 smallint, @parm6 smallint as
       Select * from PRTran
           where ChkAcct    =  @parm1
             and ChkSub     =  @parm2
             and RefNbr     =  @parm3
             and TranType   =  @parm4
             and TimeShtFlg =  @parm5
             and Paid       =  @parm6
           order by ChkAcct ,
                    ChkSub  ,
                    RefNbr  ,
                    TranType,
                    TimeShtFlg,
                    Paid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_ChkActSubRNbrTyp_TShtPd] TO [MSDSL]
    AS [dbo];

