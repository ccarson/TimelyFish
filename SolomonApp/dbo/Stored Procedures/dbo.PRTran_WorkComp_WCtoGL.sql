 Create Proc PRTran_WorkComp_WCtoGL @parm1 smalldatetime, @parm2 smalldatetime, @parm3 varchar (10) as
       Select PRTran.* from PRDoc, PRTran, Employee
              Where PRDoc.BatNbr    =  PRTran.BatNbr
                and PRDoc.Acct      =  PRTran.ChkAcct
                and PRDoc.Sub       =  PRTran.ChkSub
                and PRDoc.Chknbr    =  PRTran.Refnbr
                and PRDoc.chkdate   >= @parm1
                and PRDoc.chkdate   <= @parm2
                and PRDoc.EmpId     =  Employee.EmpId
                and Employee.CpnyId =  @parm3
                and PRTran.Rlsed    <> 0
                and PRTran.WorkComp <> ''
                and PRTran.WCtoGL   =  0
              Order By PRTran.CpnyId,
                       PRTran.WorkComp,
                       PRTran.Sub


