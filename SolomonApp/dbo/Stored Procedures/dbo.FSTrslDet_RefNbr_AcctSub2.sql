 /****** Object:  Stored Procedure dbo.FSTrslDet_RefNbr_AcctSub2    Script Date: 2/12/99 11:25:15 AM ******/
Create Proc FSTrslDet_RefNbr_AcctSub2 @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (24) As
     SELECT * FROM FSTrslDet
     WHERE RefNbr = @parm1 AND
           Acct   LIKE @parm2 AND
           Sub    LIKE @parm3
     ORDER BY RefNbr, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSTrslDet_RefNbr_AcctSub2] TO [MSDSL]
    AS [dbo];

