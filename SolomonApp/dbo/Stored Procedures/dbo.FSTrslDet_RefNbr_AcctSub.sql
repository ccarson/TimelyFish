 /****** Object:  Stored Procedure dbo.FSTrslDet_RefNbr_AcctSub    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc FSTrslDet_RefNbr_AcctSub @parm1 varchar (10) As
     SELECT * FROM FSTrslDet
     WHERE RefNbr = @parm1
     ORDER BY RefNbr, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSTrslDet_RefNbr_AcctSub] TO [MSDSL]
    AS [dbo];

