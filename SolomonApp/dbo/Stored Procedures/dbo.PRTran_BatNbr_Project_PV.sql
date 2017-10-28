 Create Proc PRTran_BatNbr_Project_PV @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (16)
as
    Select * From vs_PRTran2
     Where ((BatNbr <> '' and BatNbr = @parm1)
        or (BatNbr = '' and Project NOT IN(select Project from vs_PRTran2 where BatNbr <> '' and BatNbr = @parm2)))
       and Project Like @parm3
  Order By CurrBatNbr DESC,
           Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_Project_PV] TO [MSDSL]
    AS [dbo];

