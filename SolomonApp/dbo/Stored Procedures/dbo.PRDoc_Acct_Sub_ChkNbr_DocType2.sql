 Create Proc PRDoc_Acct_Sub_ChkNbr_DocType2 @parm1 varchar (10), @parm2 varchar (24), @parm3 smallint, @parm4 varchar (10), @parm5 varchar (10) as
SELECT *
FROM PRDoc
WHERE Acct = @parm1
      And Sub = @parm2
      And DocType IN ('HC', 'CK', 'ZC')
      And (Status = 'O' Or (Status = 'C' And @parm3 = 0))
      And CpnyId = @parm4
      And ChkNbr LIKE @parm5
ORDER BY Acct, Sub, ChkNbr, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Acct_Sub_ChkNbr_DocType2] TO [MSDSL]
    AS [dbo];

