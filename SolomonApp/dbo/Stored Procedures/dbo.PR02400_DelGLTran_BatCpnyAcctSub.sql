 Create Proc PR02400_DelGLTran_BatCpnyAcctSub @Parm1 Varchar(10), @Parm2 Varchar(10),
                @Parm3 Varchar(10), @Parm4 Varchar(24) As
        Delete GLTran
        Where BatNbr=@Parm1
                And CpnyID=@Parm2
                And Acct=@Parm3
                And Sub=@Parm4
                And Module='PR'
                AND TranType='IC'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PR02400_DelGLTran_BatCpnyAcctSub] TO [MSDSL]
    AS [dbo];

