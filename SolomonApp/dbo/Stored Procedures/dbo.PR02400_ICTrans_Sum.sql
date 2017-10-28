 Create Proc PR02400_ICTrans_Sum @Parm1 Varchar(10) As
        Select g.*
        From Batch b
        Inner Join GLTran g
                On b.BatNbr=g.BatNbr and b.Module=g.Module
        Inner Join Account a
                On a.Acct=g.Acct
        Cross Join PRSetup p
        Where b.BatNbr=@Parm1
                And b.Module='PR'
                And (g.DrAmt<>0 or g.CrAmt<>0) AND g.TranType='IC'
                And (a.SummPost='Y' Or p.GLPostOpt='S')
        Order By g.CpnyID, g.Acct, g.Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PR02400_ICTrans_Sum] TO [MSDSL]
    AS [dbo];

