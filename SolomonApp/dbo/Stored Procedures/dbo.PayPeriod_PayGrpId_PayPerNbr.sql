 Create Proc  PayPeriod_PayGrpId_PayPerNbr @parm1 varchar ( 6), @parm2 smallint as
       Select * from PayPeriod
           where PayGrpId   =  @parm1
             and PayPerNbr  =  @parm2
           order by PayGrpId,
                    PayPerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PayPeriod_PayGrpId_PayPerNbr] TO [MSDSL]
    AS [dbo];

