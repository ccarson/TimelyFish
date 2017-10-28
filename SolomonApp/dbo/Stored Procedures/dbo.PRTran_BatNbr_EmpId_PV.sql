 Create Proc PRTran_BatNbr_EmpId_PV @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (10)
as
    Select * From vs_PRTran
     Where ((BatNbr <> '' and BatNbr = @parm1)
        or (BatNbr = '' and EmpId NOT IN(select EmpId from vs_PRTran where BatNbr <> '' and BatNbr = @parm2)))
       and EmpId Like @parm3
  Order By CurrBatNbr DESC,
           EmpId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_EmpId_PV] TO [MSDSL]
    AS [dbo];

