 /****** Object:  Stored Procedure dbo.ARDoc_Select    Script Date: 4/7/98 12:49:19 PM ******/
create Proc ARDoc_Select @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
  Select * from ardoc
  Where cpnyid = @parm1
and bankacct = @parm2
and banksub = @parm3
and batnbr = @parm4
and rlsed = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Select] TO [MSDSL]
    AS [dbo];

