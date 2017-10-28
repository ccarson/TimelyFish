 Create procedure ARTran_set_Trantype @parm1 varchar (10), @parm2 varchar (15), @parm3 varchar (10) as
        UPDATE ARTran SET ARTran.TranType = "VT"
        WHERE ARTran.BatNbr = @parm1
        AND ARTran.Custid = @parm2
        AND ARTran.TranType = "PA"
        AND ARTran.RefNbr = @parm3


