 Create Proc PRCheckTrans_BatNbr_ChkSeq @BatNbr varchar (10),
                                       @ChkSeq varchar (2),
                                       @EmpId  varchar (10) as
    select p.* from PRCheckTran p, Employee e
              where p.EmpId      = e.EmpId
                and p.EmpId      = @EmpId
                and p.ChkSeq     = @ChkSeq
		and p.ASID	 = 0
                and e.CurrBatNbr = @BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRCheckTrans_BatNbr_ChkSeq] TO [MSDSL]
    AS [dbo];

